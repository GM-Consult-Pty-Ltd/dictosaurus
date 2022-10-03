// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [DictoSaurus] composition class combines a [Vocabulary],
/// [Thesaurus] and [AutoCorrect] which it uses to expose the following
/// methods:
/// - [definitionOf] the meaning of a term from a [VocabularyIndex];
/// - [synonymsOf] returns the synonyms of a term from a [SynonymsIndex];
/// - [suggestionsFor] returns alternative spellings for a term;
/// - [startsWith] returns terms from a [KGramsMap] that start with a sequence
///   of characters; and
/// - [expandTerm] expands a term using [synonymsOf] and [suggestionsFor].
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
          {required VocabularyIndex vocabularyIndex,
          required SynonymsIndex synonymsIndex,
          required KGramsMap kGramIndex,
          Tokenizer? tokenizer}) =>
      _InMemoryDictoSaurus(vocabularyIndex, synonymsIndex, kGramIndex,
          tokenizer ?? TextTokenizer().tokenize);

  /// Returns the meaning of [term].
  Future<String?> definitionOf(String term);

  /// Returns the synonyms of [term].
  Future<Set<String>> synonymsOf(String term);

  /// Returns a set of unique alternative spellings for a [term].
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<List<String>> suggestionsFor(String term, [int limit]);

  /// Returns a set of unique terms that start with [chars].
  Future<List<String>> startsWith(String chars);

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

/// Implements [DictoSaurus] by mixing in [DictoSaurusMixin].
///
/// Sub-classes must override:
/// - [autoCorrect] a [AutoCorrect] instance used by [suggestionsFor] and
///   [startsWith];
/// - [thesaurus] a [Thesaurus] instance used by [synonymsOf]; and
/// - [vocabulary] a [Vocabulary] instance used by [definitionOf].
///
abstract class DictoSaurusBase with DictoSaurusMixin {
  /// A const generative constructor for sub classes.
  const DictoSaurusBase();
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
  Future<List<String>> startsWith(String chars) =>
      autoCorrect.startsWith(chars);

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) =>
      autoCorrect.suggestionsFor(term, limit);
}

/// Implementation of [DictoSaurus] with in-memory [VocabularyIndex],
/// [SynonymsIndex] and [KGramsMap] hashmaps.
class _InMemoryDictoSaurus with DictoSaurusMixin {
  /// Instantiates a [_InMemoryDictoSaurus] with in-memory [vocabulary],
  /// [synonymsIndex] and [kGramIndex] hashmaps.
  _InMemoryDictoSaurus(VocabularyIndex vocabularyIndex,
      SynonymsIndex synonymsIndex, KGramsMap kGramIndex, Tokenizer tokenizer)
      : vocabulary = Vocabulary.inMemory(vocabularyIndex, tokenizer: tokenizer),
        thesaurus = Thesaurus.inMemory(synonymsIndex, tokenizer: tokenizer),
        autoCorrect = AutoCorrect.inMemory(kGramIndex, tokenizer: tokenizer);

  @override
  final AutoCorrect autoCorrect;

  @override
  late Thesaurus thesaurus;

  @override
  final Vocabulary vocabulary;
}

/// A [DictoSaurus] with final [autoCorrect], [thesaurus] and
/// [vocabulary] fields and a generative constructor.
class _DictoSaurusImpl extends DictoSaurusBase {
  //

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
