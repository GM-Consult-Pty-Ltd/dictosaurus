// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

///  Maps the words in a language (vocabulary) to their definitions (meanings).
///
/// Alias for `Map<String, String>`.
typedef VocabularyIndex = Map<String, String>;

/// The [Vocabulary] class exposes the [definitionOf] function, looking up
/// the meaning of a `term` in a [VocabularyIndex];
abstract class Vocabulary {
//

  /// The [TextAnalyzer] used by the [AutoCorrect] to filter terms.
  TextAnalyzer get analyzer;

  /// The [Vocabulary.inMemory] factory constructor initializes a [Vocabulary]
  /// with in-memory [VocabularyIndex] instance [vocabulary].
  ///
  /// Defaults to [English] if [analyzer] is not provided.
  factory Vocabulary.inMemory(VocabularyIndex vocabulary,
          {TextAnalyzer? analyzer}) =>
      _InMemoryVocabulary(vocabulary, analyzer ?? English());

  /// The [Vocabulary.async] factory constructor initializes a [Vocabulary]
  /// with an asynchronous callback [vocabularyCallback] to return the meaning
  /// of a term.
  ///
  /// Defaults to [English] if [analyzer] is not provided.
  factory Vocabulary.async(
          Future<String?> Function(String term) vocabularyCallback,
          {TextAnalyzer? analyzer}) =>
      _AsyncCallbackVocabulary(vocabularyCallback, analyzer ?? English());

  /// Returns the meaning of [term] from a [VocabularyIndex]. Returns null
  /// if the [VocabularyIndex] does not contain the key [term].
  Future<String?> definitionOf(Term term);
}

//TODO VocabularyMixin with analyzer

/// The [Vocabulary.inMemory] factory constructor initializes a
/// [Vocabulary] with in-memory [VocabularyIndex] instance [vocabulary].
class _InMemoryVocabulary implements Vocabulary {
  //

  @override
  final TextAnalyzer analyzer;

  /// An in-memory [VocabularyIndex].
  final VocabularyIndex vocabulary;

  /// Initializes a const [_InMemoryVocabulary] with the in-memory
  /// [VocabularyIndex] parameter [vocabulary].
  const _InMemoryVocabulary(this.vocabulary, this.analyzer);

  @override
  Future<String?> definitionOf(Term term) async => vocabulary[term];
}

/// Implementation of [Vocabulary] that uses an asynchronous callback
/// [vocabularyCallback] to  return the meaning of a term.
class _AsyncCallbackVocabulary implements Vocabulary {
//

  @override
  final TextAnalyzer analyzer;

  /// A asynchronous callback that returns a set of synonyms for a term.
  final Future<String?> Function(String term) vocabularyCallback;

  /// Initializes a const [_AsyncCallbackVocabulary] with an asynchronous callback
  /// [vocabularyCallback] that  returns a set of synonyms for a term..\
  const _AsyncCallbackVocabulary(this.vocabularyCallback, this.analyzer);

  @override
  Future<String?> definitionOf(String term) async => vocabularyCallback(term);
}
