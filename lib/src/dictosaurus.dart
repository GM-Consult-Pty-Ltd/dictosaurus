// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

/// The [DictoSaurus] composition class leverages a [Vocabulary],
/// [Thesaurus] and [AutoCorrect] which it uses to expose the following
/// methods:
/// - [definitionOf];,
/// - [synonymsOf];
/// - [suggestionsFor] ; and
/// - [expandTerm] .
abstract class DictoSaurus {
  //

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [vocabulary] instances.
  factory DictoSaurus(
          {required Vocabulary vocabulary,
          required Thesaurus thesaurus,
          required AutoCorrect autoCorrect}) =>
      _DictoSaurusImpl(autoCorrect, thesaurus, vocabulary);

  /// The [DictoSaurus.inMemory] factory constructor initializes a [DictoSaurus]
  /// with in-memory [vocabulary], [synonymsIndex] and [kGramIndex] hashmaps.
  factory DictoSaurus.inMemory(
          {required VocabularyIndex vocabulary,
          required SynonymsIndex synonymsIndex,
          required KGramIndex kGramIndex}) =>
      _InMemoryDictoSaurus(vocabulary, synonymsIndex, kGramIndex);

  /// Returns the meaning of [term] from a [VocabularyIndex]. Returns null
  /// if the [VocabularyIndex] does not contain the key [term].
  Future<String?> definitionOf(String term);

  /// Asynchronously returns the synonyms of [term] from a [SynonymsIndex].
  Future<Set<String>> synonymsOf(String term);

  /// Returns a set of unique alternative spellings for a [term] by converting
  /// the [term] to k-grams and then finding the best matches for the [term]
  /// from a k-gram index, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> suggestionsFor(String term, [int limit]);

  /// Expands [term] to an ordered list of terms.
  ///
  /// If [term] exists in the vocabulary, the returned list will include
  /// the [term] and then its synonyms.
  ///
  /// If [term] is not found in the vocabulary, terms with similar spellings
  /// will be returned, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the first [limit] terms will be returned.
  Future<List<String>> expandTerm(String term, [int limit]);
}

/// A mixin class that implements [DictoSaurus.definitionOf],
/// [DictoSaurus.synonymsOf], [DictoSaurus.suggestionsFor] and
/// [DictoSaurus.expandTerm].
///
/// Implementations that mix in [DictoSaurusMixin] must override:
/// - [vocabulary] is ;
abstract class DictoSaurusMixin implements DictoSaurus {
  //

  /// A [Vocabulary] instance used by [definitionOf].
  Vocabulary get vocabulary;

  /// A [Thesaurus] instance used by [synonymsOf].
  Thesaurus get thesaurus;

  /// A [AutoCorrect] instance used by [suggestionsFor].
  AutoCorrect get autoCorrect;

  @override
  Future<List<String>> expandTerm(String term, [int limit = 5]) async {
    final retVal = <Term>[];
    final synonyms = await vocabulary.definitionOf(term);
    if (synonyms != null) {
      retVal.add(term);
      retVal.addAll(await thesaurus.synonymsOf(term));
    } else {
      retVal.addAll(await autoCorrect.suggestionsFor(term, limit));
    }
    return (retVal.length > limit) ? retVal.sublist(0, limit) : retVal;
  }

  @override
  Future<String?> definitionOf(String term) => vocabulary.definitionOf(term);

  @override
  Future<Set<String>> synonymsOf(String term) => thesaurus.synonymsOf(term);

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) =>
      autoCorrect.suggestionsFor(term, limit);
}

/// Implementation of [DictoSaurus] with in-memory [VocabularyIndex],
/// [SynonymsIndex] and [KGramIndex] hashmaps.
class _InMemoryDictoSaurus with DictoSaurusMixin {
  /// Instantiates a [_InMemoryDictoSaurus] with in-memory [vocabulary],
  /// [synonymsIndex] and [kGramIndex] hashmaps.
  _InMemoryDictoSaurus(VocabularyIndex vocabularyIndex,
      SynonymsIndex synonymsIndex, KGramIndex kGramIndex)
      : vocabulary = Vocabulary.inMemory(vocabularyIndex),
        thesaurus = Thesaurus.inMemory(synonymsIndex),
        autoCorrect = AutoCorrect.inMemory(kGramIndex);

  @override
  final AutoCorrect autoCorrect;

  @override
  late Thesaurus thesaurus;

  @override
  final Vocabulary vocabulary;
}

class _DictoSaurusImpl with DictoSaurusMixin {
  @override
  final AutoCorrect autoCorrect;

  @override
  final Thesaurus thesaurus;

  @override
  final Vocabulary vocabulary;

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [vocabulary] instances.
  const _DictoSaurusImpl(this.autoCorrect, this.thesaurus, this.vocabulary);
}
