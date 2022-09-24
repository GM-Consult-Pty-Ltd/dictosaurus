// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';

///  Maps the words in a language (vocabulary) to their definitions (meanings).
///
/// Alias for `Map<String, String>`.
typedef DefinitionsIndex = Map<String, String>;

/// The [Vocabulary]() class exposes the [definitionOf] function, looking up
/// the meaning of a `term` in a [DefinitionsIndex];
abstract class Vocabulary {
//

  /// The [Vocabulary.inMemory] factory constructor initializes a
  /// [Vocabulary] with in-memory [DefinitionsIndex] instance [vocabulary].
  factory Vocabulary.inMemory(DefinitionsIndex vocabulary) =>
      _VocabularyInMemory(vocabulary);

  /// Returns the meaning of [term] from a [DefinitionsIndex]. Returns null
  /// if the [DefinitionsIndex] does not contain the key [term].
  Future<String?> definitionOf(Term term);
}

class _VocabularyInMemory implements Vocabulary {
  //

  /// An in-memory [DefinitionsIndex].
  final DefinitionsIndex vocabulary;

  /// Initializes a const [_VocabularyInMemory] with the in-memory
  /// [DefinitionsIndex] parameter [vocabulary].
  const _VocabularyInMemory(this.vocabulary);

  @override
  Future<String?> definitionOf(Term term) async => vocabulary[term];
}
