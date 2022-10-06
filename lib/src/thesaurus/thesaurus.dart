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

/// Mixin class that implements the [Thesaurus] interface:
/// - [synonymsCallback] is an asynchronous callback that returns the synonyms
///   for a term from a dictionary provider; and
/// - the [synonymsOf] method returns a set  of synonyms for a term by calling
///   [synonymsCallback].
abstract class ThesaurusMixin implements Thesaurus {
  //

  /// An asynchronous callback that returns a set of synonyms for a term from
  /// a dictionary provider.
  SynonymsCallback get synonymsCallback;

  @override
  Future<Set<String>> synonymsOf(String term) => synonymsCallback(term);
}

/// An abstract base class that that implements the [Thesaurus] interface:
/// - [synonymsCallback] is an asynchronous callback that returns the synonyms
///   for a term from a dictionary provider; and
/// - the [synonymsOf] method returns a set  of synonyms for a term by calling
///   [synonymsCallback].
///
/// Provides a default const unnamed generative constructor for sub classes.
abstract class ThesaurusBase with ThesaurusMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const ThesaurusBase();
}

/// Implementation of [Thesaurus] for the [Thesaurus] factory:
/// - [synonymsCallback] is an asynchronous callback that returns the synonyms
///   for a term from a dictionary provider; and
/// - the [synonymsOf] method returns a set  of synonyms for a term by calling
///   [synonymsCallback].
class _ThesaurusImpl extends ThesaurusBase {
//

  @override
  final SynonymsCallback synonymsCallback;

  /// Initializes a const [_ThesaurusImpl] with [synonymsCallback].
  const _ThesaurusImpl(this.synonymsCallback);
}
