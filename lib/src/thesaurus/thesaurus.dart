// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [Thesaurus] interface exposes methods that return a term's
/// [synonymsOf] and/or [antonymsOf] from a dictionary provider.
abstract class Thesaurus {
  //

  /// The unnamed [Thesaurus] factory constructor initializes a [Thesaurus]
  /// that uses a [Dictionary] to retrieve term's [synonymsOf] and/or
  /// [antonymsOf] from a dictionary provider.
  factory Thesaurus(
          {required TermExpander synonymsCallback,
          required TermExpander antonymsCallback}) =>
      _ThesaurusImpl(synonymsCallback, antonymsCallback);

  /// The [Thesaurus.dictionary] factory constructor initializes a [Thesaurus]
  /// with a [dictionary] to return the synonyms  or antonyms for a term from
  /// a [TermProperties] object returned by [dictionary].
  factory Thesaurus.dictionary(Dictionary dictionary) =>
      _ThesaurusWithDictionaryImpl(dictionary);

  /// Returns a set of synonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> synonymsOf(String term, [PartOfSpeech? partOfSpeech]);

  /// Returns a set of antonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Future<Set<String>> antonymsOf(String term, [PartOfSpeech? partOfSpeech]);

//
}

/// A mixin class that implements [Thesaurus] and uses [getEntry] to retrieve
/// [TermProperties] from which it extracts [synonymsOf] and [antonymsOf] a
/// term.
///
/// Mix this class intoa [Dictionary] to add [Thesaurus] methods.
abstract class ThesaurusMixin implements Thesaurus {
  //

  /// Returns a [TermProperties] for [term].
  Future<TermProperties?> getEntry(String term);

  @override
  Future<Set<String>> synonymsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final retVal = <String>{};
    final dictEntry = await getEntry(term);
    if (dictEntry != null) {
      if (partOfSpeech == null) {
        retVal.addAll(dictEntry.allSynonyms);
      } else {
        for (final e in dictEntry.synonymsMap.entries) {
          if (e.key == partOfSpeech) {
            retVal.addAll(e.value);
          }
        }
      }
    }
    return retVal;
  }

  @override
  Future<Set<String>> antonymsOf(String term,
      [PartOfSpeech? partOfSpeech]) async {
    final retVal = <String>{};
    final dictEntry = await getEntry(term);
    if (dictEntry != null) {
      if (partOfSpeech == null) {
        retVal.addAll(dictEntry.allAntonyms);
      } else {
        for (final e in dictEntry.antonymsMap.entries) {
          if (e.key == partOfSpeech) {
            retVal.addAll(e.value);
          }
        }
      }
    }
    return retVal;
  }
}

class _ThesaurusWithDictionaryImpl with ThesaurusMixin {
  //

  const _ThesaurusWithDictionaryImpl(this.dictionary);

  @override
  Future<TermProperties?> getEntry(String term) => dictionary.getEntry(term);

  final Dictionary dictionary;
}

/// Implementation of [Thesaurus] for the [Thesaurus] unnamed factory:
/// - [synonymsCallback] is an asynchronous callback that returns the synonyms
///   for a term from a dictionary provider; and
/// - the [synonymsOf] method returns a set  of synonyms for a term by calling
///   [synonymsCallback].
class _ThesaurusImpl implements Thesaurus {
//

  /// An asynchronous callback that returns a set of synonyms for a term from
  /// a dictionary provider.
  final TermExpander synonymsCallback;

  /// An asynchronous callback that returns a set of antonyms for a term from
  /// a dictionary provider.
  final TermExpander antonymsCallback;

  @override
  Future<Set<String>> synonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      synonymsCallback(term, partOfSpeech);

  @override
  Future<Set<String>> antonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      antonymsCallback(term, partOfSpeech);

  /// Initializes a const [_ThesaurusImpl] with [synonymsCallback].
  const _ThesaurusImpl(this.synonymsCallback, this.antonymsCallback);
}
