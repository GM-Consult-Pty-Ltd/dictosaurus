// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

/// The [AutoCorrect] class exposes [suggestionsFor] function that returns a
/// set of unique alternative spellings for a term by converting the
/// term to k-grams and then finding the best matches for the (misspelt)
/// term from the k-gram index, ordered in descending order of relevance
/// (i.e. best match first).
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
  factory AutoCorrect.async(KGramIndexLoader kGramIndexLoader, [int k = 3]) =>
      _AsyncCallbackAutoCorrect(kGramIndexLoader, k);

  /// Returns a set of unique alternative spellings for a [term] by converting
  /// the [term] to k-grams and then finding the best matches for the [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> suggestionsFor(String term, [int limit]);

  /// Returns a set of unique terms from a KGramIndex that start with [chars].
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> startsWith(String chars, [int limit]);
}

/// A mixin class that implements [AutoCorrect.suggestionsFor]. Classes that
/// mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [KGramIndex];
/// - [kGramIndexLoader], a ansynchronous callback function that returns a [KGramIndex]
///   for a collection of k-grams.
abstract class AutoCorrectMixin implements AutoCorrect {
  //

  /// The length of the k-grams in the [KGramIndex].
  int get k;

  /// A function or callback that asynchronously returns a subset of a
  /// [KGramIndex] for a collection of [KGram] strings.
  KGramIndexLoader get kGramIndexLoader;

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) async {
    final termGrams = term.kGrams(k);
    final kGramTerms = (await kGramIndexLoader(termGrams)).terms;
    return term.matches(kGramTerms, k: 2, limit: limit);
  }
  //   final entries = similarities.entries.toList();
  //   entries.sort(((a, b) => b.value.compareTo(a.value)));
  //   final retVal = entries.map((e) => e.key).toList();
  //   return retVal.length > limit ? retVal.sublist(0, limit) : retVal;
  // }

  @override
  Future<List<String>> startsWith(String chars, [int limit = 10]) {
    // TODO: implement startsWith
    throw UnimplementedError();
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

/// Implementation of [AutoCorrect] that uses an asynchronous callback
/// [kGramIndexLoader] to  return a set of synonyms for a term.
class _AsyncCallbackAutoCorrect with AutoCorrectMixin {
//

  @override
  final KGramIndexLoader kGramIndexLoader;

  @override
  final int k;

  /// Initializes a const [_AsyncCallbackAutoCorrect] with an asynchronous callback
  /// [kGramIndexLoader] that  returns a set of synonyms for a term..\
  const _AsyncCallbackAutoCorrect(this.kGramIndexLoader, this.k);
}
