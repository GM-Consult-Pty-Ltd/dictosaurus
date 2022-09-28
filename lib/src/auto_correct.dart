// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

/// The [AutoCorrect] class exposes the [suggestionsFor] function that returns
/// a set of unique alternative spellings for a term.
abstract class AutoCorrect {
  //

  /// The [AutoCorrect.inMemory] factory constructor initializes a [AutoCorrect]
  /// with the in-memory [KGramIndex] instance [kGramIndex].
  factory AutoCorrect.inMemory(KGramIndex kGramIndex) {
    assert(kGramIndex.isNotEmpty);
    final k = kGramIndex.keys.first.length;
    return _InMemoryAutoCorrect(kGramIndex, k);
  }

  /// The [AutoCorrect.async] factory constructor initializes a [AutoCorrect]
  /// that uses an asynchronous callback [kGramIndexLoader] to return the
  /// k-grams for a term.
  factory AutoCorrect.async(
          Future<KGramIndex> Function(Iterable<Term> terms) kGramIndexLoader,
          [int k = 3]) =>
      _AsyncCallbackAutoCorrect(kGramIndexLoader, k);

  /// Returns a set of unique alternative spellings for a [term].
  ///
  /// Converts [term] to k-grams and then finding the best matches for [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> suggestionsFor(String term, [int limit]);

  /// Returns a set of unique terms from a KGramIndex that start with [chars].
  Future<List<String>> startsWith(String chars);
}

/// A mixin class that implements [AutoCorrect.suggestionsFor].
///
/// Classes that mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [KGramIndex];
/// - [kGramIndexLoader], a ansynchronous callback function that returns a [KGramIndex]
///   for a collection of k-grams.
abstract class AutoCorrectMixin implements AutoCorrect {
  //

  /// The length of the k-grams in the [KGramIndex].
  int get k;

  /// A function or callback that asynchronously returns a subset of a
  /// [KGramIndex] for a collection of [KGram] strings.
  Future<KGramIndex> Function(Iterable<Term> terms) get kGramIndexLoader;

//Future<Map<String, Set<String>>> Function(Iterable<String> kGrams)
  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) async {
    if (term.isEmpty) {
      return [];
    }
    final termGrams = term.kGrams(k);
    final kGramTerms = (await kGramIndexLoader(termGrams)).terms;
    return term.matches(kGramTerms, k: 2, limit: limit);
  }

  @override
  Future<List<String>> startsWith(String chars) async {
    if (chars.isEmpty) {
      return [];
    }
    final termGrams = chars.kGrams(k);
    final kGramIndex = (await kGramIndexLoader(termGrams));
    final startsWithTerms = (kGramIndex[termGrams.first] ?? {})
        .where((element) => element.startsWith(chars))
        .toList();
    startsWithTerms.sort(((a, b) => a.compareTo(b)));
    return startsWithTerms;
  }
}

/// Implementation class for factory constructor [AutoCorrect.inMemory].
class _InMemoryAutoCorrect with AutoCorrectMixin {
  //

  /// A in-memory [KGramIndex] instance.
  final KGramIndex kGramIndex;

  /// Instantiate a const [_InMemoryAutoCorrect]
  const _InMemoryAutoCorrect(this.kGramIndex, this.k);

  @override
  KGramIndexLoader get kGramIndexLoader => ([terms]) async {
        terms = terms ?? [];
        final KGramIndex retVal = {};
        for (final kGram in terms) {
          final entry = kGramIndex[kGram];
          if (entry != null) {
            retVal[kGram] = entry;
          }
        }
        return retVal;
      };

  @override
  final int k;
}

/// Implementation class for factory constructor [AutoCorrect.async].
///
/// Uses an asynchronous callback [kGramIndexLoader] to return alternative
/// spellings for a term.
class _AsyncCallbackAutoCorrect with AutoCorrectMixin {
//

  @override
  final Future<KGramIndex> Function(Iterable<Term> terms) kGramIndexLoader;

  @override
  final int k;

  /// Initializes a const [_AsyncCallbackAutoCorrect] with an asynchronous callback
  /// [kGramIndexLoader] that  returns a set of synonyms for a term..\
  const _AsyncCallbackAutoCorrect(this.kGramIndexLoader, this.k);
}
