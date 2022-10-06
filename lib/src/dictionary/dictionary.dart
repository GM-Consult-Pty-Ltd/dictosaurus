// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'dictionary_entry.dart';

/// The [Dictionary] interface:
/// - exposes the [definitionsOf] method that returns a set of definitions of
///   a term and its tokenized versions; and
/// - the [getEntry] is used to get tokenized versions of a term and should be
///   the same as that used to create the dictionary index queried by the
///   [Dictionary].
abstract class Dictionary {
//

  /// Returns a [DictionaryEntry] for [term] from the [Dictionary].
  Future<DictionaryEntry?> getEntry(String term);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with an asynchronous [dictionaryCallback] to return the meaning of a term.
  factory Dictionary(
          Future<DictionaryEntry> Function(String term) dictionaryCallback) =>
      _DictionaryImpl(dictionaryCallback);
}

/// Mixin class that implements the [Dictionary] interface:
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a collection of terms from a dictionary index; and
/// - the [getEntry] method synchronously gets the meaning of the term using
///   the [dictionaryCallback].
abstract class DictionaryMixin implements Dictionary {
  //

  @override
  Future<DictionaryEntry?> getEntry(String term) => dictionaryCallback(term);

  /// A asynchronous callback that returns the meanings of a collection of
  /// terms.
  Future<DictionaryEntry> Function(String term) get dictionaryCallback;
}

/// An abstract base class that implements the [Dictionary] interface:
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a term from a dictionary index; and
/// - the [getEntry] method synchronously gets the meaning of the term using
///   the [dictionaryCallback].
///
/// Provides a default const unnamed generative constructor for sub classes.
abstract class DictionaryBase with DictionaryMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const DictionaryBase();

  //
}

/// Implementation of [DictionaryBase] used by [Dictionary] factory.
class _DictionaryImpl extends DictionaryBase {
//

  @override
  final Future<DictionaryEntry> Function(String term) dictionaryCallback;

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that returns a [DictionaryEntry] for a term.
  const _DictionaryImpl(this.dictionaryCallback);
}
