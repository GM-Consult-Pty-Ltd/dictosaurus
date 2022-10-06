// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [Thesaurus] interface exposes the [synonymsOf] method returns a set
/// of synonyms for a term from a dictionary provider.
abstract class Thesaurus {
  //

  /// The unnamed [Thesaurus] factory constructor initializes a [Thesaurus]
  /// with an asynchronous callback [synonymsCallback] to return the synonyms
  /// for a term from a dictionary provider.
  factory Thesaurus(SynonymsCallback synonymsCallback,
          {Tokenizer? tokenizer}) =>
      _ThesaurusImpl(synonymsCallback);

  /// Returns a set of synonyms for [term] from a dictionary provider.
  Future<Set<String>> synonymsOf(String term);

//
}

/// Implementation of [Thesaurus] for the [Thesaurus] factory:
/// - [synonymsCallback] is an asynchronous callback that returns the synonyms
///   for a term from a dictionary provider; and
/// - the [synonymsOf] method returns a set  of synonyms for a term by calling
///   [synonymsCallback].
class _ThesaurusImpl implements Thesaurus {
//

  /// An asynchronous callback that returns a set of synonyms for a term from
  /// a dictionary provider.
  final SynonymsCallback synonymsCallback;

  @override
  Future<Set<String>> synonymsOf(String term) => synonymsCallback(term);

  /// Initializes a const [_ThesaurusImpl] with [synonymsCallback].
  const _ThesaurusImpl(this.synonymsCallback);
}
