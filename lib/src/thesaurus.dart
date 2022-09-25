// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

/// Maps the words in a language (synonymsIndex) to a collection of unique
/// synonyms. The synonyms collection can be empty.
///
/// Alias for `Map<Term, Set<Term>>`.
typedef SynonymsIndex = Map<Term, Set<Term>>;

/// The [Thesaurus] class exposes the [synonymsOf] function that asynchronously
/// returns the synonyms of a term from a [SynonymsIndex].
abstract class Thesaurus {
  //

  /// The [Thesaurus.inMemory] factory constructor initializes a [Thesaurus]
  /// with in-memory [SynonymsIndex] instance [synonymsIndex].
  factory Thesaurus.inMemory(SynonymsIndex synonymsIndex) =>
      _InMemoryThesaurus(synonymsIndex);

  /// The [Thesaurus.async] factory constructor initializes a [Thesaurus]
  /// with an asynchronous callback [synonymsCallback] to return the synonyms
  /// for a term.
  factory Thesaurus.async(
          Future<Set<String>> Function(String term) synonymsCallback) =>
      _AsyncCallbackThesaurus(synonymsCallback);

  /// Asynchronously returns the synonyms of [term] from a [SynonymsIndex].
  Future<Set<String>> synonymsOf(String term);
}

/// Implementation of [Thesaurus] that uses a in-memory [SynonymsIndex].
class _InMemoryThesaurus implements Thesaurus {
//

  /// An in-memory [SynonymsIndex].
  final SynonymsIndex synonymsIndex;

  /// Initializes a const [_InMemoryThesaurus] with a in-memory [synonymsIndex].
  const _InMemoryThesaurus(this.synonymsIndex);

  @override
  Future<Set<String>> synonymsOf(String term) async =>
      synonymsIndex[term] ?? {};
}

/// Implementation of [Thesaurus] that uses an asynchronous callback
/// [synonymsCallback] to  return a set of synonyms for a term.
class _AsyncCallbackThesaurus implements Thesaurus {
//

  /// A asynchronous callback that returns a set of synonyms for a term.
  final Future<Set<String>> Function(String term) synonymsCallback;

  /// Initializes a const [_AsyncCallbackThesaurus] with an asynchronous callback
  /// [synonymsCallback] that  returns a set of synonyms for a term..\
  const _AsyncCallbackThesaurus(this.synonymsCallback);

  @override
  Future<Set<String>> synonymsOf(String term) async => synonymsCallback(term);
}
