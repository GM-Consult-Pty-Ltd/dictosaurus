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
      InMemoryThesaurus(synonymsIndex);

  /// The [Thesaurus.inMemory] factory constructor initializes a [Thesaurus]
  /// with in-memory [SynonymsIndex] instance [synonymsIndex].
  factory Thesaurus.async(
          Future<Set<String>> Function(String term) synonymsCallback) =>
      AsyncCallbackThesaurus(synonymsCallback);

  /// Asynchronously returns the synonyms of [term] from a [SynonymsIndex].
  Future<Set<String>> synonymsOf(String term);
}

/// Implementation of [Thesaurus] that uses a in-memory [SynonymsIndex].
class InMemoryThesaurus implements Thesaurus {
//

  /// An in-memory [SynonymsIndex].
  final SynonymsIndex synonymsIndex;

  /// Initializes a const [InMemoryThesaurus] with a in-memory [synonymsIndex].
  const InMemoryThesaurus(this.synonymsIndex);

  @override
  Future<Set<String>> synonymsOf(String term) async =>
      synonymsIndex[term] ?? {};
}

/// Implementation of [Thesaurus] that uses an asynchronous callback
/// [synonymsCallback] to  return a set of synonyms for a term.
class AsyncCallbackThesaurus implements Thesaurus {
//

  /// A asynchronous callback that returns a set of synonyms for a term.
  final Future<Set<String>> Function(String term) synonymsCallback;

  /// Initializes a const [AsyncCallbackThesaurus] with an asynchronous callback
  /// [synonymsCallback] that  returns a set of synonyms for a term..\
  const AsyncCallbackThesaurus(this.synonymsCallback);

  @override
  Future<Set<String>> synonymsOf(String term) async => synonymsCallback(term);
}
