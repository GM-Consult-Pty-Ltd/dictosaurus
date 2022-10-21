// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:text_analysis/extensions.dart';

/// The [AutoCorrect] interface exposes the [suggestionsFor] and [startsWith]
/// methods.
/// - [suggestionsFor] returns a linked set of unique alternative spellings for
///   a term and its tokenized versions.
/// - [startsWith] returns an ordered list of unique terms that start with a
///   sequence of characters from a k-grams index.
abstract class AutoCorrect {
  //

  /// Returns a set of unique alternative spellings for a [term].
  ///
  /// Converts [term] to k-grams and then finding the best matches for [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> suggestionsFor(String term, [int limit]);

  /// Returns an ordered list of unique terms that start with [chars] from a
  /// k-grams index.
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> startsWith(String chars, [int limit = 10]);

  /// Static factory [AutoCorrect.kGram] initializes a [AutoCorrect] with an
  /// asynchronous callback [kGramIndexLoader], used by [suggestionsFor] and
  /// [startsWith] to analyze text.
  static AutoCorrectBase kGram(
          Future<Map<String, Set<String>>> Function(Iterable<String> terms)
              kGramIndexLoader,
          {int k = 2}) =>
      _AutoCorrectImpl(kGramIndexLoader, k);
}

/// An abstract class that implements the [AutoCorrect] interface.
///
/// Classes that mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [Map<String, Set<String>>]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a
///   [Map<String, Set<String>>] for a collection of k-grams.
abstract class AutoCorrectBase with AutoCorrectMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const AutoCorrectBase();

  //
}

/// A mixin class that implements the [AutoCorrect.suggestionsFor] and
/// [AutoCorrect.startsWith] methods.
///
/// Classes that mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [Map<String, Set<String>>]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a [Map<String, Set<String>>]
///   for a collection of k-grams.
abstract class AutoCorrectMixin implements AutoCorrect {
  //

  /// The length of the k-grams in the [Map<String, Set<String>>].
  int get k;

  /// A function or callback that asynchronously returns a subset of a
  /// [Map<String, Set<String>>] for a collection of [String] strings.
  Future<Map<String, Set<String>>> Function(Iterable<String> kGrams)
      get kGramIndexLoader;

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) async {
    if (term.isEmpty) {
      return [];
    }
    final termGrams = term.kGrams(k);
    final kGramTerms = (await kGramIndexLoader(termGrams)).terms;
    return term.matches(kGramTerms, k: k, limit: limit);
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

/// Implementation class for unnamed factory constructor [AutoCorrect].
///
/// Uses an asynchronous callback [kGramIndexLoader] to return alternative
/// spellings for a term.
class _AutoCorrectImpl extends AutoCorrectBase {
//

  @override
  final Future<Map<String, Set<String>>> Function(Iterable<String> terms)
      kGramIndexLoader;

  @override
  final int k;

  /// Initializes a const [_AutoCorrectImpl] with an asynchronous callback
  /// [kGramIndexLoader] that  returns a set of synonyms for a term.
  const _AutoCorrectImpl(this.kGramIndexLoader, this.k);
}

/// Extension methods on `Map<String, Set<String>>`.
extension _KGramIndexExtension on Map<String, Set<String>> {
  //

  /// Returns a set of unique terms by iterating over all the [values] in the
  /// collection and adding the terms to a [Set].
  Set<String> get terms {
    final kGramTerms = <String>{};
    for (final terms in values) {
      kGramTerms.addAll(terms);
    }
    return kGramTerms;
  }
}
