// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// The [Dictionary] is an API for return the language properties of a term
/// or a translation of a term.
///
/// The [Dictionary] interface has two methods that return [TermProperties]:
/// - [getEntry], a function that returns a [TermProperties] for a term; and
/// - [translate], a function that returns translations for a term as
///   [TermProperties].
///
/// The unnamed `Dictionary()` factory constructor initializes a [Dictionary]
/// with an asynchronous [DictionaryCallback] to return the meaning of a term
/// from a dictionary provider.
abstract class Dictionary {
//

  /// The [Language] of terms in the dictionary.
  Language get language;

  /// Returns translations for [term] from [sourceLanguage] to [language] as
  /// [TermProperties].
  ///
  /// Optionally specify the [endpoint] to include in the returned
  /// [TermProperties] instance, useful where different API endpoints are
  /// queried for specific properties.
  Future<TermProperties?> translate(String term, Language sourceLanguage);

  /// Returns a [TermProperties] for [term].
  ///
  /// Optionally specify the [endpoint] to include in the returned
  /// [TermProperties] instance, useful where different API endpoints are
  /// queried for specific properties.
  Future<TermProperties?> getEntry(String term, [DictionaryEndpoint? endpoint]);

  /// Returns a set of phrases for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> phrasesWith(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of inflections for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<Pronunciation>> pronunciationsOf(String term,
      [PartOfSpeech? partOfSpeech]);

  /// Returns a set of inflections for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> etymologiesOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of inflections for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> inflectionsOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of definitions for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> definitionsFor(String term, [PartOfSpeech? partOfSpeech]);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with [dictionaryCallback], [translationCallback] and [language].
  factory Dictionary(DictionaryCallback dictionaryCallback,
          TranslationCallback translationCallback,
          [Language language = Language.en_US]) =>
      _DictionaryImpl(dictionaryCallback, translationCallback, language);
}

/// An abstract/mixin class that implements the [definitionsFor],
/// [phrasesWith] and [inflectionsOf] methods of [Dictionary].
abstract class DictionaryMixin implements Dictionary {
  @override
  Future<Set<String>> phrasesWith(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, DictionaryEndpoint.phrases);
    return dictEntry != null ? dictEntry.phrasesWith(partOfSpeech) : <String>{};
  }

  @override
  Future<Set<String>> etymologiesOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, DictionaryEndpoint.definitions);
    return dictEntry != null ? dictEntry.etymologiesOf(partOfSpeech) : {};
  }

  @override
  Future<Set<Pronunciation>> pronunciationsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, DictionaryEndpoint.definitions);
    return dictEntry != null ? dictEntry.pronunciationsOf(partOfSpeech) : {};
  }

  @override
  Future<Set<String>> definitionsFor(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, DictionaryEndpoint.definitions);
    return dictEntry != null ? dictEntry.definitionsFor(partOfSpeech) : {};
  }

  @override
  Future<Set<String>> inflectionsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, DictionaryEndpoint.inflections);
    return (dictEntry != null) ? dictEntry.inflectionsOf(partOfSpeech) : {};
  }
}

/// An abstract class with [DictionaryMixin] that implements the [Dictionary]
/// interface.
///
/// Sub-classes must override:
/// - [language], the [Language] of terms in the dictionary;
/// - [getEntry], a function that returns a [TermProperties] for a term; and
/// - [translate], a function that returns translations for a term as
///   [TermProperties].
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
  final Language language;

  @override
  Future<TermProperties?> getEntry(String term,
          [DictionaryEndpoint? endpoint]) =>
      dictionaryCallback(term, endpoint);

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final TranslationCallback translationCallback;

  @override
  Future<TermProperties?> translate(String term, Language sourceLanguage) =>
      translationCallback(term, sourceLanguage);

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that returns a [TermProperties] for a term.
  const _DictionaryImpl(
      this.dictionaryCallback, this.translationCallback, this.language);
}
