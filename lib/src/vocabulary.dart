// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

///  Maps the words in a language (vocabulary) to their definitions (meanings).
///
/// Alias for `Map<String, String>`.
typedef VocabularyIndex = Map<String, String>;

/// The [Vocabulary] class exposes the [definitionOf] function, looking up
/// the meaning of a `term` in a [VocabularyIndex];
abstract class Vocabulary {
//

  /// The [Vocabulary.inMemory] factory constructor initializes a [Vocabulary]
  /// with in-memory [VocabularyIndex] instance [vocabulary].
  factory Vocabulary.inMemory(VocabularyIndex vocabulary) =>
      _InMemoryVocabulary(vocabulary);

  /// The [Vocabulary.async] factory constructor initializes a [Vocabulary]
  /// with an asynchronous callback [vocabularyCallback] to return the meaning
  /// of a term.
  factory Vocabulary.async(
          Future<String?> Function(String term) vocabularyCallback) =>
      _AsyncCallbackVocabulary(vocabularyCallback);

  /// Returns the meaning of [term] from a [VocabularyIndex]. Returns null
  /// if the [VocabularyIndex] does not contain the key [term].
  Future<String?> definitionOf(Term term);
}

/// The [Vocabulary.inMemory] factory constructor initializes a
/// [Vocabulary] with in-memory [VocabularyIndex] instance [vocabulary].
class _InMemoryVocabulary implements Vocabulary {
  //

  /// An in-memory [VocabularyIndex].
  final VocabularyIndex vocabulary;

  /// Initializes a const [_InMemoryVocabulary] with the in-memory
  /// [VocabularyIndex] parameter [vocabulary].
  const _InMemoryVocabulary(this.vocabulary);

  @override
  Future<String?> definitionOf(Term term) async => vocabulary[term];
}

/// Implementation of [Vocabulary] that uses an asynchronous callback
/// [vocabularyCallback] to  return the meaning of a term.
class _AsyncCallbackVocabulary implements Vocabulary {
//

  /// A asynchronous callback that returns a set of synonyms for a term.
  final Future<String?> Function(String term) vocabularyCallback;

  /// Initializes a const [_AsyncCallbackVocabulary] with an asynchronous callback
  /// [vocabularyCallback] that  returns a set of synonyms for a term..\
  const _AsyncCallbackVocabulary(this.vocabularyCallback);

  @override
  Future<String?> definitionOf(String term) async => vocabularyCallback(term);
}
