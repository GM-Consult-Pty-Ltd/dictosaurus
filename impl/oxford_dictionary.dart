// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';
import 'package:dictosaurus/src/dictionary/dictionary.dart';
import 'package:dictosaurus/type_definitions.dart';
import 'package:gmconsult_dart_core/dart_core.dart';
import 'dart:async';

import 'package:gmconsult_proprietary/gmconsult_proprietary.dart';

// part 'http_mixin.dart';

/// Implements [Dictionary] with the `Oxford Dictionaries` API as dictionary
/// provider.  See: https://developer.oxforddictionaries.com/.
class OxfordDictionaries
    with OxfordDictionariesApiMixin, DictionaryMixin
    implements Dictionary {
  //

  @override
  String get languageCode => 'en_US';

  /// Hydrates a [OxfordDictionaries] instance:
  /// - [appId] is the `OxfordDictionaries Application ID`;
  /// - [appKey] is the `OxfordDictionaries Application Key`;
  /// - [languageCode] is the ISO language code of the [Dictionary].
  const OxfordDictionaries();

  @override
  String get appId =>
      GMConsultKeys.oxfordDictionariesHeaders['app_id'] as String;

  @override
  String get appKey =>
      GMConsultKeys.oxfordDictionariesHeaders['app_key'] as String;

  @override
  Future<TermProperties?> getEntry(String term,
      [bool strictMatch = false]) async {
    final sourceLanguage = languageCode.replaceAll('_', '-').toLowerCase();
    final json = await entriesEndPoint(term,
        sourceLanguage: sourceLanguage, strictMatch: strictMatch);
    if (json != null) {
      final retVal = json.toTermProperties();
      return retVal;
    }
    return null;
  }
}

extension _OxfordDictionariesHashmapExtension on Map<String, dynamic> {
  //

  /// Maps the `lexicalCategory` field an element of `[lexicalEntries]`
  /// as [PartOfSpeech] if it exists.
  PartOfSpeech? get poS {
    final json = this['lexicalCategory'] is Map
        ? ((this['lexicalCategory']) as Map)
            .map((key, value) => MapEntry(key.toString(), value))
        : null;
    if (json != null) {
      final value = json['id'];
      switch (value) {
        case 'noun':
          return PartOfSpeech.noun;
        case 'pronoun':
          return PartOfSpeech.pronoun;
        case 'adjective':
          return PartOfSpeech.adjective;
        case 'verb':
          return PartOfSpeech.verb;
        case 'adverb':
          return PartOfSpeech.adverb;
        case 'preposition':
          return PartOfSpeech.noun;
        case 'conjunction':
          return PartOfSpeech.conjunction;
        case 'interjection':
          return PartOfSpeech.interjection;
        case 'article':
          return PartOfSpeech.article;
        default:
          return null;
      }
    }
    return null;
  }

  /// Maps the `inflections` field an element of [lexicalEntryEntries] to a
  /// Set of [String] if the field exists.
  Set<String> get lexicalEntriesEntryInflections {
    final retVal = <String>{};
    final collection = getJsonList('inflections');
    for (final json in collection) {
      final value = json['inflectedForm'];
      if (value is String) {
        retVal.add(value);
      }
    }
    return retVal;
  }

  /// Maps the `lexicalCategory` field an element of [lexicalEntries]
  /// as [PartOfSpeech] if it exists.
  Set<String> getTextValues(String fieldName) {
    final retVal = <String>{};
    final phrases = getJsonList(fieldName);
    for (final json in phrases) {
      final phrase = json['text'];
      if (phrase is String) {
        retVal.add(phrase);
      }
    }
    return retVal;
  }

  /// Returns the `id` field of the JSON response as `String?`.
  String? get term => this['id'] is String ? this['id'] as String : null;

  /// Returns the `language` field of the JSON response as `String?`.
  String? get language =>
      (this['language'] is String ? this['language'] as String : null)
          ?.replaceAll('-', '_');

  /// Returns the first phonetic spelling found in the `pronunciations` field
  /// of an element of `"lexicalEntry" "entries"`.
  String? get lexicalEntriesEntryPhonetic {
    final collection = getJsonList('pronunciations');
    String? retVal;
    for (final json in collection) {
      final value = json['phoneticSpelling'];
      if (value is String) {
        retVal = retVal ?? value;
      }
      return retVal;
    }
    return null;
  }

  Iterable<JSON> getJsonList(String fieldName) => this[fieldName] is Iterable
      ? (this[fieldName] as Iterable).cast<JSON>()
      : [];

  Iterable<String> getStringList(String fieldName) =>
      this[fieldName] is Iterable
          ? (this[fieldName] as Iterable).cast<String>()
          : [];

  TermProperties? toTermProperties() {
    final term = this.term;
    String languageCode = '';
    final Iterable<JSON> results = getJsonList('results');
    if (results.isNotEmpty && term is String) {
      languageCode =
          languageCode.isEmpty ? results.first.language ?? '' : languageCode;
      final variants = <TermDefinition>{};
      String? stem;
      String? lemma;
      String? phonetic;
      for (final r in results) {
        final lexicalEntries = r.getJsonList('lexicalEntries');
        for (final le in lexicalEntries) {
          final partOfSpeech = le.poS;
          final phrases = <String>{};
          if (partOfSpeech != null) {
            final entries = le.getJsonList('entries');
            for (final e in entries) {
              final inflections = e.lexicalEntriesEntryInflections;
              phonetic = phonetic ?? e.lexicalEntriesEntryPhonetic;
              final senses = e.getJsonList('senses');
              for (final s in senses) {
                final synonyms = s.getTextValues('synonyms');
                final definitions = s.getStringList('definitions');
                for (final definition in definitions) {
                  phrases.addAll(s.getTextValues('examples'));
                  final variant = TermDefinition(
                      term: term,
                      partOfSpeech: partOfSpeech,
                      definition: definition,
                      phrases: phrases,
                      antonyms: {},
                      inflections: inflections,
                      synonyms: synonyms);
                  variants.add(variant);
                }
                final subsenses = s.getJsonList('subsenses');
                for (final ss in subsenses) {
                  final definitions = ss.getStringList('definitions');
                  for (final definition in definitions) {
                    phrases.addAll(s.getTextValues('examples'));
                    final variant = TermDefinition(
                        term: term,
                        partOfSpeech: partOfSpeech,
                        definition: definition,
                        phrases: phrases,
                        antonyms: {},
                        inflections: inflections,
                        synonyms: synonyms);
                    variants.add(variant);
                  }
                }
              }
            }
          }
        }
      }
      return TermProperties(
          term: term,
          stem: stem ?? term,
          lemma: lemma ?? term,
          phonetic: phonetic ?? term,
          languageCode: languageCode,
          variants: variants);
    }
    return null;
  }
}

/// Enumeration of the `Oxford Dictionaries` API endpoints.
///
/// See: https://developer.oxforddictionaries.com/.
enum OxFordDictionariesEndpoints {
  /// Retrieve definitions, pronunciations, example sentences, grammatical
  /// information and word origins.
  entries,

  /// Retrieve the the possible lemmas for a given inflected word.
  lemmas,

  /// Search for headword matches, translations or synonyms for a word.
  search,

  /// Return translations for a given word.
  translations,

  ///  Retrieve words that are similar/opposite in meaning to the input word
  /// (synonym/antonym).
  thesaurus,

  /// Retrieve sentences extracted from a corpus of real-world language,
  /// including news and blog content.
  sentences,

  /// A collection of utility endpoints.
  ///
  /// See https://developer.oxforddictionaries.com/documentation#/ for
  /// available paths.
  utility,

  /// Retrieve definitions, examples and other information for a given
  /// dictionary word or an inflection.
  words,

  /// Retrieve all the inflections of a given word.
  inflections
}

/// A mixin that returns [JSON] responses from the Oxford Dictionaries API.
///
/// See: https://developer.oxforddictionaries.com/.
abstract class OxfordDictionariesApiMixin {
  //

  /// The host part of the API request.
  String get host => 'od-api.oxforddictionaries.com';

  /// The `OxfordDictionaries Application ID`.
  ///
  /// Get an Application ID at
  /// `https://developer.oxforddictionaries.com/documentation/getting_started`
  String get appId;

  /// The `OxfordDictionaries Application Key`.
  ///
  /// Get an Application Key at
  /// `https://developer.oxforddictionaries.com/documentation/getting_started`
  String get appKey;

  /// Returns the [appId] and [appKey] as headers for the HTTP request.
  Map<String, String> get headers => {'app_id': appId, 'app_key': appKey};

  /// Hashmap of endpoint to valid language codes.
  static const kLanguagesMap = {
    OxFordDictionariesEndpoints.entries: {
      'en-gb',
      'en-us',
      'de',
      'es',
      'fr',
      'gu',
      'hi',
      'lv',
      'ro',
      'sw',
      'ta'
    }
  };

  /// Query the `Words` endpoint:
  /// - [term] is the word to query.
  /// - [strictMatch] specifies whether diacritics must match exactly. If
  ///   "false", near-homographs for the given word_id will also be selected
  ///   (e.g., rose matches both rose and rosé; similarly rosé matches both);
  ///
  ///
  ///
  /// More information at:
  /// https://developer.oxforddictionaries.com/documentation#!/Words/get_words_source_lang
  Future<JSON?> entriesEndPoint(String term,
      {bool strictMatch = false, String sourceLanguage = 'en-us'}) async {
    final languages =
        kLanguagesMap[OxFordDictionariesEndpoints.entries] as Set<String>;
    if (languages.contains(sourceLanguage) && term.isNotEmpty) {
      final path = 'api/v2/entries/$sourceLanguage/${term.toLowerCase()}';
      final queryParameters = {'strictMatch': strictMatch.toString()};
      final json = await JsonApi().get(
          host: host,
          path: path,
          headers: headers,
          queryParameters: queryParameters,
          isHttps: true);

      final id = json['id'];
      if (id == term.toLowerCase()) {
        return json;
      }
    }
    return null;
  }
}