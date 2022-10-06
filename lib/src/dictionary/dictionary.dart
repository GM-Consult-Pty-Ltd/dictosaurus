// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import '../typedefs.dart';
import 'dictionary_entry.dart';

/// The [Dictionary] interface exposes the [getEntry] method that returns
/// a [DictionaryEntry] for a term.
///
///
/// The unnamed `Dictionary()` factory constructor initializes a [Dictionary]
/// with an asynchronous [DictionaryCallback] to return the meaning of a term
/// from a dictionary provider.
abstract class Dictionary {
//

  /// The ISO language code for the language of the [term].
  String get languageCode;

  /// Returns a [DictionaryEntry] for [term].
  Future<DictionaryEntry?> getEntry(String term);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with the [dictionaryCallback] to return the meaning of a term
  /// from a dictionary provider.
  factory Dictionary(DictionaryCallback dictionaryCallback,
          [String languageCode = 'en_US']) =>
      _DictionaryImpl(dictionaryCallback, languageCode);
}

/// Implementation of [Dictionary] used by the unnamed `Dictionary()` factory
/// constructor:
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a collection of terms from a dictionary index; and
/// - the [getEntry] method asynchronously gets the meaning of the term using
///   the [dictionaryCallback].
class _DictionaryImpl implements Dictionary {
//

  @override
  final String languageCode;

  @override
  Future<DictionaryEntry?> getEntry(String term) => dictionaryCallback(term);

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that returns a [DictionaryEntry] for a term.
  const _DictionaryImpl(this.dictionaryCallback, this.languageCode);
}
