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
  /// with in-memory [KGramIndex] instance [kGramIndex].
  factory AutoCorrect.inMemory(KGramIndex kGramIndex) {
    assert(kGramIndex.isNotEmpty);
    final k = kGramIndex.keys.first.length;
    return InMemoryAutoCorrect(kGramIndex, k);
  }

  /// Returns a set of unique alternative spellings for a [term] by converting
  /// the [term] to k-grams and then finding the best matches for the [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  Future<List<String>> suggestionsFor(String term, [int limit]);
}

/// A mixin class that implements [AutoCorrect.suggestionsFor]. Classes that
/// mix in [AutoCorrectMixin] must override:
/// - [k], the length of the k-grams in the [KGramIndex];
/// - [getKGrams], a ansynchronous callback function that returns a [KGramIndex]
///   for a collection of k-grams.
abstract class AutoCorrectMixin implements AutoCorrect {
  //

  /// The length of the k-grams in the [KGramIndex].
  int get k;

  /// A function or callback that asynchronously returns a subset of a
  /// [KGramIndex] for a collection of [KGram] strings.
  KGramIndexLoader get getKGrams;

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) async {
    final termGrams = term.kGrams(k);
    final kGramTerms = (await getKGrams(termGrams)).terms;
    final suggestionsMap = term.jaccardSimilarityMap(kGramTerms, k);
    final entries = suggestionsMap.entries.toList();
    entries.sort(((a, b) => b.value.compareTo(a.value)));
    final retVal = entries.map((e) => e.key).toList();
    return retVal.length > limit ? retVal.sublist(0, limit) : retVal;
  }
}

/// Implementation class for factory constructor [AutoCorrect.inMemory].
class InMemoryAutoCorrect with AutoCorrectMixin {
  //

  /// A in-memory [KGramIndex] instance.
  final KGramIndex kGramIndex;

  /// Instantiate a const [InMemoryAutoCorrect]
  const InMemoryAutoCorrect(this.kGramIndex, this.k);

  @override
  KGramIndexLoader get getKGrams => ([terms]) async {
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
