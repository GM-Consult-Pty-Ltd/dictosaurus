// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// The [Dictionary] is an API for return the language properties of a term
/// or a translation of a term.
/// - [getEntry] returns a [DictionaryEntry] for a term; and
/// - [translate] returns translations for a term as as a collection of
///   [TermVariant]s.
///
/// The unnamed `Dictionary()` factory constructor initializes a [Dictionary]
/// with [DictionaryCallback] and [TranslationCallback] functions.
abstract class Dictionary {
//

  /// The [Language] of terms in the dictionary.
  Language get language;

  /// Returns translations for [term] from [language] to [targetLanguage] as
  /// a collection of [TermVariant] objects.
  Future<Set<TermVariant>> translate(String term, Language targetLanguage);

  /// Returns a [DictionaryEntry] for [term].
  Future<DictionaryEntry?> getEntry(String term);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with [dictionaryCallback], [translationCallback] and [language].
  factory Dictionary(DictionaryCallback dictionaryCallback,
          TranslationCallback translationCallback,
          [Language language = Language.en_US]) =>
      _DictionaryImpl(dictionaryCallback, translationCallback, language);
}

/// Implementation of [Dictionary] used by the unnamed `Dictionary()` factory
/// constructor.
/// - [getEntry] asynchronously gets the meaning of the term using
///   the [dictionaryCallback].
/// - [translate] returns translations for a term using [translationCallback].
class _DictionaryImpl implements Dictionary {
//

  @override
  final Language language;

  @override
  Future<DictionaryEntry?> getEntry(String term) => dictionaryCallback(term);

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final TranslationCallback translationCallback;

  @override
  Future<Set<TermVariant>> translate(String term, Language targetLanguage) =>
      translationCallback(term, language, targetLanguage);

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that returns a [DictionaryEntry] for a term.
  const _DictionaryImpl(
      this.dictionaryCallback, this.translationCallback, this.language);
}
