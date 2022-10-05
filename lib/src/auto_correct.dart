// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [AutoCorrect] interface:
/// - exposes the [suggestionsFor] method that returns a linked set of unique
///   alternative spellings for a term and its tokenized versions;
/// - exposes the [startsWith] method that returns an ordered list of unique
///   terms that start with a sequence of characters from a k-grams index.
///
/// The [tokenizer] is used to get tokenized versions of a term and should be
/// the same as that used to create the k-grams index queried by the
/// [AutoCorrect].
abstract class AutoCorrect {
  //

  /// Returns a set of unique alternative spellings for a [term] and its
  /// tokenized versions.
  ///
  /// Converts [term] to k-grams and then finding the best matches for [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<Map<String, List<String>>> suggestionsFor(String term, [int limit]);

  /// Returns an ordered list of unique terms that start with [chars] from a
  /// k-grams index.
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> startsWith(String chars, [int limit = 10]);

  /// The [tokenizer] is used to get tokenized versions of a term.
  ///
  /// The [tokenizer] should be the same as that used to create the k-gram
  /// index queried by the [AutoCorrect].
  Tokenizer get tokenizer;

  /// The [AutoCorrect.inMemory] factory constructor initializes a [AutoCorrect]
  /// with the in-memory [KGramsMap] instance [kGramIndex] and [tokenizer].
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and should be
  /// the same as that used to create the k-grams index queried by the
  /// [AutoCorrect].
  factory AutoCorrect.inMemory(KGramsMap kGramIndex, {Tokenizer? tokenizer}) {
    assert(kGramIndex.isNotEmpty);
    final k = kGramIndex.keys.first.length;
    return _InMemoryAutoCorrect(
        kGramIndex, k, tokenizer ?? TextTokenizer().tokenize);
  }

  /// The unnamed factory constructor initializes a [AutoCorrect] that uses an
  /// asynchronous callback [kGramIndexLoader] to return the k-grams for a term.
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and should be
  /// the same as that used to create the k-grams index queried by the
  /// [AutoCorrect].
  factory AutoCorrect(
          Future<KGramsMap> Function(Iterable<Term> terms) kGramIndexLoader,
          {Tokenizer? tokenizer,
          int k = 3}) =>
      _AutoCorrectImpl(
          kGramIndexLoader, k, tokenizer ?? TextTokenizer().tokenize);
}

/// An abstract class that implements the [AutoCorrect] interface:
///
/// Classes that mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [KGramsMap];
/// - the [tokenizer] is used to get tokenized versions of a term and should be
///   the same as that used to create the k-grams index queried by the
///   [AutoCorrect]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a
///   [KGramsMap] for a collection of k-grams.
abstract class AutoCorrectBase with AutoCorrectMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const AutoCorrectBase();

  //
}

/// A mixin class that implements [AutoCorrect.suggestionsFor].
///
/// Classes that mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [KGramsMap];
/// - the [tokenizer] is used to get tokenized versions of a term and should be
///   the same as that used to create the k-grams index queried by the
///   [AutoCorrect]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a [KGramsMap]
///   for a collection of k-grams.
abstract class AutoCorrectMixin implements AutoCorrect {
  //

  /// The length of the k-grams in the [KGramsMap].
  int get k;

  /// A function or callback that asynchronously returns a subset of a
  /// [KGramsMap] for a collection of [KGram] strings.
  Future<KGramsMap> Function(Iterable<KGram> kGrams) get kGramIndexLoader;

  @override
  Future<Map<String, List<String>>> suggestionsFor(String term,
      [int limit = 10]) async {
    final retVal = <String, List<String>>{};
    if (term.isEmpty) {
      // return an empty map if the term is empty
      return retVal;
    }
    final terms = <String>[term];
    final tokens = (await tokenizer(term));
    terms.addAll(tokens.map((e) => e.term));
    final termGrams = term.kGrams(k);
    for (final token in tokens) {
      termGrams.addAll(token.term.kGrams(k));
    }
    final kGramTerms = (await kGramIndexLoader(termGrams)).terms;
    for (final t in terms.toSet()) {
      retVal[t] = t.matches(kGramTerms);
    }
    return retVal;
  }

  @override
  Future<List<String>> startsWith(String chars, [int limit = 10]) async {
    if (chars.isEmpty) {
      return [];
    }
    final termGrams = chars.kGrams(k);
    final kGramIndex = (await kGramIndexLoader([termGrams.first]));
    if (kGramIndex.isNotEmpty) {
      final startsWithTerms = (kGramIndex[termGrams.first] ?? {})
          .where((element) => element.startsWith(chars))
          .toList();
      startsWithTerms.sort(((a, b) => a.compareTo(b)));
      startsWithTerms.sort(((a, b) => a.length.compareTo(b.length)));
      return startsWithTerms.length > limit
          ? startsWithTerms.sublist(0, limit)
          : startsWithTerms;
    }
    return [];
  }
}

/// Implementation class for factory constructor [AutoCorrect.inMemory].
class _InMemoryAutoCorrect with AutoCorrectMixin {
  //

  /// Instantiate a const [_InMemoryAutoCorrect]
  const _InMemoryAutoCorrect(this.kGramIndex, this.k, this.tokenizer);

  /// A in-memory [KGramsMap] instance.
  final KGramsMap kGramIndex;

  @override
  final int k;

  @override
  final Tokenizer tokenizer;

  @override
  KGramsMapLoader get kGramIndexLoader => ([terms]) async {
        terms = terms ?? [];
        final KGramsMap retVal = {};
        for (final kGram in terms) {
          final entry = kGramIndex[kGram];
          if (entry != null) {
            retVal[kGram] = entry;
          }
        }
        return retVal;
      };
}

/// Implementation class for uunamed factory constructor [AutoCorrect].
///
/// Uses an asynchronous callback [kGramIndexLoader] to return alternative
/// spellings for a term.
class _AutoCorrectImpl with AutoCorrectMixin {
//

  @override
  final Future<KGramsMap> Function(Iterable<Term> terms) kGramIndexLoader;

  @override
  final int k;

  @override
  final Tokenizer tokenizer;

  /// Initializes a const [_AutoCorrectImpl] with an asynchronous callback
  /// [kGramIndexLoader] that  returns a set of synonyms for a term..\
  const _AutoCorrectImpl(this.kGramIndexLoader, this.k, this.tokenizer);
}
