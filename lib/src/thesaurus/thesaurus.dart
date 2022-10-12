// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [Thesaurus] interface exposes methods that return a term's
/// [synonymsOf], [lemmasOf] and/or [antonymsOf] from a dictionary provider.
abstract class Thesaurus {
  //

  /// The [Thesaurus.callBack] factory constructor initializes a [Thesaurus]
  /// that uses callbacks to retrieve term's [synonymsOf], [lemmasOf] and/or
  /// [antonymsOf] from a dictionary provider.
  factory Thesaurus.callBack(
          {required TermExpander synonymsCallback,
          required TermExpander antonymsCallback,
          required TermExpander lemmasCallback}) =>
      _ThesaurusCallbackImpl(
          synonymsCallback, antonymsCallback, lemmasCallback);

  /// Unnamed factory constructor initializes a [Thesaurus] that returns the
  /// synonyms or antonyms for a term from a [TermProperties] object returned
  /// by [dictionaryCallback].
  factory Thesaurus(DictionaryCallback dictionaryCallback) =>
      _ThesaurusImpl(dictionaryCallback);

  /// The [Thesaurus.dictionary] factory constructor initializes a [Thesaurus]
  /// with a [dictionary] to return the synonyms  or antonyms for a term from
  /// a [TermProperties] object returned by [dictionary].
  factory Thesaurus.dictionary(Dictionary dictionary) =>
      _ThesaurusWithDictionaryImpl(dictionary);

  /// Returns a set of synonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> synonymsOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of lemmas for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> lemmasOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of antonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> antonymsOf(String term, [PartOfSpeech? partOfSpeech]);

//
}

/// A mixin class that implements [Thesaurus] and uses [getEntry] to retrieve
/// [TermProperties] from which it extracts [synonymsOf], [lemmasOf] and/or
/// [antonymsOf] a term.
///
/// Mix this class into a [Dictionary] to add [Thesaurus] methods.
abstract class ThesaurusMixin implements Thesaurus {
  //

  /// Returns a [TermProperties] for [term].
  Future<TermProperties?> getEntry(String term,
      [Iterable<TermProperty>? fields]);

  @override
  Future<Set<String>> synonymsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, {TermProperty.synonyms});
    return dictEntry != null ? dictEntry.synonymsOf(partOfSpeech) : {};
  }

  @override
  Future<Set<String>> lemmasOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, {TermProperty.lemmas});
    return dictEntry != null ? dictEntry.lemmasOf(partOfSpeech) : {};
  }

  @override
  Future<Set<String>> antonymsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final dictEntry = await getEntry(term, {TermProperty.antonyms});
    return dictEntry != null ? dictEntry.antonymsOf(partOfSpeech) : {};
  }
}

/// An abstract class that implements the [Thesaurus] interface.
///
/// Sub-classes must override [getEntry], a function that returns
/// [TermProperties] for a term.
abstract class ThesaurusBase with ThesaurusMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const ThesaurusBase();

  //
}

/// Private implementation class used by [Thesaurus.dictionary] factory.
class _ThesaurusWithDictionaryImpl extends ThesaurusBase {
  //

  const _ThesaurusWithDictionaryImpl(this.dictionary);

  @override
  Future<TermProperties?> getEntry(String term,
          [Iterable<TermProperty>? fields]) =>
      dictionary.getEntry(term);

  final Dictionary dictionary;
}

/// Private implementation class used by [Thesaurus] unnamed factory.
class _ThesaurusImpl extends ThesaurusBase {
  //

  /// Asynchronous callback that returns the properties of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  const _ThesaurusImpl(this.dictionaryCallback);

  @override
  Future<TermProperties?> getEntry(String term,
          [Iterable<TermProperty>? fields]) =>
      dictionaryCallback(term, fields);
}

/// Implementation of [Thesaurus] for the [Thesaurus.callBack] factory.
class _ThesaurusCallbackImpl implements Thesaurus {
//

  /// An asynchronous callback that returns a set of synonyms for a term from
  /// a dictionary provider.
  final TermExpander synonymsCallback;

  /// An asynchronous callback that returns a set of lemmas for a term from
  /// a dictionary provider.
  final TermExpander lemmasCallback;

  /// An asynchronous callback that returns a set of antonyms for a term from
  /// a dictionary provider.
  final TermExpander antonymsCallback;

  @override
  Future<Set<String>> synonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      synonymsCallback(term, partOfSpeech);

  @override
  Future<Set<String>> lemmasOf(String term, [PartOfSpeech? partOfSpeech]) =>
      lemmasCallback(term, partOfSpeech);

  @override
  Future<Set<String>> antonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      antonymsCallback(term, partOfSpeech);

  /// Initializes a const [_ThesaurusCallbackImpl] with [synonymsCallback].
  const _ThesaurusCallbackImpl(
      this.synonymsCallback, this.antonymsCallback, this.lemmasCallback);
}
