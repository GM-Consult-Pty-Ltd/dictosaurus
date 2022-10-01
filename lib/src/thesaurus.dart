// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [Thesaurus] class exposes the [synonymsOf] function that asynchronously
/// returns the synonyms of a term from a [SynonymsIndex].
abstract class Thesaurus {
  //

  /// The [TextAnalyzer] used by the [AutoCorrect] to filter terms.
  TextAnalyzer get analyzer;

  /// The [Thesaurus.inMemory] factory constructor initializes a [Thesaurus]
  /// with in-memory [SynonymsIndex] instance [synonymsIndex].
  ///
  /// Defaults to [English] if [analyzer] is not provided.
  factory Thesaurus.inMemory(SynonymsIndex synonymsIndex,
          {TextAnalyzer? analyzer}) =>
      _InMemoryThesaurus(synonymsIndex, analyzer ?? English());

  /// The [Thesaurus.async] factory constructor initializes a [Thesaurus]
  /// with an asynchronous callback [synonymsCallback] to return the synonyms
  /// for a term.
  ///
  /// Defaults to [English] if [analyzer] is not provided.
  factory Thesaurus.async(
          Future<Set<String>> Function(String term) synonymsCallback,
          {TextAnalyzer? analyzer}) =>
      _AsyncCallbackThesaurus(synonymsCallback, analyzer ?? English());

  /// Asynchronously returns the synonyms of [term] from a [SynonymsIndex].
  Future<Set<String>> synonymsOf(String term);
}

//TODO ThesaurusMixin with analyzer

/// Implementation of [Thesaurus] that uses a in-memory [SynonymsIndex].
class _InMemoryThesaurus implements Thesaurus {
//

  @override
  final TextAnalyzer analyzer;

  /// An in-memory [SynonymsIndex].
  final SynonymsIndex synonymsIndex;

  /// Initializes a const [_InMemoryThesaurus] with a in-memory [synonymsIndex].
  const _InMemoryThesaurus(this.synonymsIndex, this.analyzer);

  @override
  Future<Set<String>> synonymsOf(String term) async =>
      synonymsIndex[term.toLowerCase()] ?? {};
}

/// Implementation of [Thesaurus] that uses an asynchronous callback
/// [synonymsCallback] to  return a set of synonyms for a term.
class _AsyncCallbackThesaurus implements Thesaurus {
//

  @override
  final TextAnalyzer analyzer;

  /// A asynchronous callback that returns a set of synonyms for a term.
  final Future<Set<String>> Function(String term) synonymsCallback;

  /// Initializes a const [_AsyncCallbackThesaurus] with an asynchronous callback
  /// [synonymsCallback] that  returns a set of synonyms for a term..\
  const _AsyncCallbackThesaurus(this.synonymsCallback, this.analyzer);

  @override
  Future<Set<String>> synonymsOf(String term) async =>
      synonymsCallback(term.toLowerCase());
}
