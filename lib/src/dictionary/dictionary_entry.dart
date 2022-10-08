// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/dictionary/part_of_speech.dart';
import 'term_variant.dart';

/// Object model for an entry in a [Dictionary] with immutable properties:
/// - [term] is the term or word for this entry;
/// - [stem] is the stemmed version of [term];
/// - [lemma] is the lemma of [term];
/// - [languageCode] is the ISO language code for the language of the
///   [term];
/// - [variants] is an un-ordered collection of unique [TermDefinition]
///   instances;
/// - [allAntonyms] maps all the antonyms from [variants] to a set;
/// - [allDefinitions] maps all the definitions from [variants] to a set;
/// - [allInflections] maps all the inflections from [variants] to a set;
/// - [allPhrases] maps all the phrases from [variants] to a set;
/// - [allSynonyms] maps all the synonyms from [variants] to a set;
/// - [antonymsMap] maps [PartOfSpeech] to antonyms from [variants];
/// - [definitionsMap] maps [PartOfSpeech] to definitions from [variants];
/// - [inflectionsMap] maps [PartOfSpeech] to inflections from [variants];
/// - [phrasesMap] maps [PartOfSpeech] to phrases from [variants]; and
/// - [synonymsMap] maps [PartOfSpeech] to synonyms from [variants].
abstract class TermProperties {
  //

  /// Factory constructor that instantiates an immutable [TermProperties]
  /// instance:
  /// - [languageCode] is the ISO language code for the language of the
  ///   [term];
  /// - [term] is the term or word for this entry;
  /// - [stem] is the stemmed version of [term];
  /// - [lemma] is the lemma of [term];
  /// - [phonetic] is the phonetic representation of [term] when pronounced in
  ///   [languageCode]; and
  /// - [variants] is an un-ordered collection of unique [TermDefinition]
  ///   instances.
  ///
  /// The [variants] field of the implementation class is immutable as it
  /// returns a copy of a private variable.
  factory TermProperties(
          {required String term,
          required String stem,
          required String lemma,
          required String phonetic,
          required String languageCode,
          required Iterable<TermDefinition> variants}) =>
      _TermProperties(
          languageCode, term, stem, lemma, phonetic, variants.toSet());

  /// The ISO language code for the language of the [term].
  String get languageCode;

  /// The term for this entry.
  String get term;

  /// The stemmed version of [term].
  String get stem;

  /// The lemma of [term].
  String get lemma;

  /// The phonetic representation of [term] when pronounced in [languageCode].
  String get phonetic;

  /// An un-ordered collection of unique [TermDefinition] instances.
  Set<TermDefinition> get variants;

  /// A hashmap of [PartOfSpeech] to terms that are synonyms of [term].
  Map<PartOfSpeech, Set<String>> get synonymsMap;

  /// A hashmap of [PartOfSpeech] to terms that are antonyms of [term].
  Map<PartOfSpeech, Set<String>> get antonymsMap;

  /// A hashmap of [PartOfSpeech] to definitions that are synonyms of [term].
  Map<PartOfSpeech, Set<String>> get definitionsMap;

  /// A hashmap of [PartOfSpeech] to phrases using [term].
  Map<PartOfSpeech, Set<String>> get phrasesMap;

  /// A hashmap of [PartOfSpeech] to inflections that are inflections of [term].
  Map<PartOfSpeech, Set<String>> get inflectionsMap;

  /// An unordered collection of unique definitions for [term].
  Set<String> get allDefinitions;

  /// An unordered collection of unique terms that are synonyms of [term].
  Set<String> get allSynonyms;

  /// An unordered collection of unique terms that are antonyms of [term].
  Set<String> get allAntonyms;

  /// An unordered collection of unique terms that are inflections of [term].
  Set<String> get allInflections;

  /// An unordered collection of unique example phrases that include [term].
  Set<String> get allPhrases;
}

/// Abstract mixin class of [TermProperties] that implements:
/// - the `==` operator by comparing type and the [term], [languageCode] and
///   [variants] properties;
/// - [hashCode] returns an Object.hash of the [term], [languageCode] and
///   [variants] properties;
/// - [allAntonyms] maps all the antonyms from [variants] to a set;
/// - [allDefinitions] maps all the definitions from [variants] to a set;
/// - [allInflections] maps all the inflections from [variants] to a set;
/// - [allPhrases] maps all the phrases from [variants] to a set;
/// - [allSynonyms] maps all the synonyms from [variants] to a set;
/// - [antonymsMap] maps [PartOfSpeech] to antonyms from [variants];
/// - [definitionsMap] maps [PartOfSpeech] to definitions from [variants];
/// - [inflectionsMap] maps [PartOfSpeech] to inflections from [variants];
/// - [phrasesMap] maps [PartOfSpeech] to phrases from [variants]; and
/// - [synonymsMap] maps [PartOfSpeech] to synonyms from [variants].
abstract class TermPropertiesMixin implements TermProperties {
  //

  @override
  Set<String> get allAntonyms {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.antonyms);
    }
    return retVal;
  }

  @override
  Set<String> get allDefinitions => variants.map((e) => e.definition).toSet();

  @override
  Set<String> get allInflections {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.inflections);
    }
    return retVal;
  }

  @override
  Set<String> get allPhrases {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.phrases);
    }
    return retVal;
  }

  @override
  Set<String> get allSynonyms {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.synonyms);
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> get antonymsMap {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.antonyms);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> get definitionsMap {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.add(e.definition);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> get inflectionsMap {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.inflections);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> get phrasesMap {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.phrases);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> get synonymsMap {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.synonyms);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  bool operator ==(Object other) =>
      other is TermProperties &&
      term == other.term &&
      languageCode == other.languageCode &&
      variants.intersection(other.variants).length == variants.length;

  @override
  int get hashCode => Object.hash(term, languageCode, variants);
}

/// Implementation class for [TermProperties], extends [TermPropertiesBase].
class _TermProperties with TermPropertiesMixin {
  //

  /// Private final field for [variants].
  final Set<TermDefinition> _variants;

  /// An un-ordered collection of unique [TermDefinition] instances.
  @override
  Set<TermDefinition> get variants => Set<TermDefinition>.from(_variants);

  @override
  final String languageCode;

  @override
  final String term;

  const _TermProperties(this.languageCode, this.term, this.stem, this.lemma,
      this.phonetic, this._variants);

  @override
  final String lemma;

  @override
  final String stem;

  @override
  final String phonetic;
}
