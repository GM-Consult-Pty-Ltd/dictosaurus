// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import '_index.dart';
import '../typedefs.dart';

/// The [Dictionary] interface exposes the [getEntry] method that returns
/// a [TermProperties] for a term.
///
/// The unnamed `Dictionary()` factory constructor initializes a [Dictionary]
/// with an asynchronous [DictionaryCallback] to return the meaning of a term
/// from a dictionary provider.
abstract class Dictionary {
//

  /// The ISO language code for the language of a term.
  String get languageCode;

  /// Returns a [TermProperties] for [term].
  Future<TermProperties?> getEntry(String term);

  /// Returns a set of phrases for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> phrasesWith(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of inflections for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> inflectionsOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of definitions for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> definitionsFor(String term, [PartOfSpeech? partOfSpeech]);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with the [dictionaryCallback] to return the meaning of a term
  /// from a dictionary provider.
  factory Dictionary(DictionaryCallback dictionaryCallback,
          [String languageCode = 'en_US']) =>
      _DictionaryImpl(dictionaryCallback, languageCode);
}

/// An abstract/mixin class that implements the [definitionsFor],
/// [phrasesWith] and [inflectionsOf] methods of [Dictionary].
abstract class DictionaryMixin implements Dictionary {
  @override
  Future<Set<String>> phrasesWith(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term);
    return dictEntry != null ? dictEntry.phrasesWith(partOfSpeech) : <String>{};
  }

  @override
  Future<Set<String>> definitionsFor(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term);
    return dictEntry != null ? dictEntry.definitionsFor(partOfSpeech) : {};
  }

  @override
  Future<Set<String>> inflectionsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term);
    return (dictEntry != null) ? dictEntry.inflectionsOf(partOfSpeech) : {};
  }
}

/// An abstract class with [DictionaryMixin] that implements the [Dictionary]
/// interface.
///
/// Sub-classes must override:
/// - [languageCode], the ISO language code for the language of a term; and
/// - [getEntry], a function that returns a [TermProperties] for a term.
abstract class DictionaryBase with DictionaryMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const DictionaryBase();

  //
}

/// Implementation of [Dictionary] used by the unnamed `Dictionary()` factory
/// constructor.
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a collection of terms from a dictionary index.
/// - [getEntry] asynchronously gets the meaning of the term using
///   the [dictionaryCallback].
class _DictionaryImpl extends DictionaryBase {
//

  @override
  final String languageCode;

  @override
  Future<TermProperties?> getEntry(String term) => dictionaryCallback(term);

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that returns a [TermProperties] for a term.
  const _DictionaryImpl(this.dictionaryCallback, this.languageCode);
}
