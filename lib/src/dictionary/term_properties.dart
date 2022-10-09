// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/dictionary/part_of_speech.dart';
import 'term_variant.dart';

/// An `object model` for a `term` or `word` with immutable properties.
///
/// The folling fields enumerate the object properties:
/// - [term] is the term or word for this entry;
/// - [stem] is the stemmed version of [term];
/// - [lemma] is the lemma of [term];
/// - [languageCode] is the ISO language code for the language of the
///   [term];
/// - [variants] is an un-ordered collection of unique [TermDefinition]
///   instances.
///
/// The following methods map [variants] of the [term] to useful return values:
/// - [phrasesWith] returns a set of phrases containing [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [inflectionsOf] returns a set of inflections of [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [definitionsFor] returns a set of definitions for [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [synonymsOf] returns a set of synonyms of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [antonymsOf] returns a set of antonyms of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [allAntonyms] maps all the antonyms to a set;
/// - [allDefinitions] maps all the definitions to a set;
/// - [allInflections] maps all the inflections to a set;
/// - [allPhrases] maps all the phrases to a set;
/// - [allSynonyms] maps all the synonyms to a set;
/// - [antonymsMap] maps [PartOfSpeech] to antonyms;
/// - [definitionsMap] maps [PartOfSpeech] to definitions;
/// - [inflectionsMap] maps [PartOfSpeech] to inflections;
/// - [phrasesMap] maps [PartOfSpeech] to phrases; and
/// - [synonymsMap] maps [PartOfSpeech] to synonyms].
abstract class TermProperties {
  //

  /// A factory constructor that instantiates an immutable [TermProperties]
  /// instance.
  /// - [languageCode] is the ISO language code for the language of the [term].
  /// - [term] is the term or word for this [TermProperties].
  /// - [stem] is the stemmed version of [term].
  /// - [lemma] is the lemma of [term].
  /// - [phonetic] is the phonetic representation of [term] when pronounced in
  ///   [languageCode].
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
      _TermPropertiesImpl(
          languageCode, term, stem, lemma, phonetic, variants.toSet());

  /// The ISO language code for the language of the [term].
  String get languageCode;

  /// The term for this [TermProperties].
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
  Map<PartOfSpeech, Set<String>> synonymsMap();

  /// A hashmap of [PartOfSpeech] to terms that are antonyms of [term].
  Map<PartOfSpeech, Set<String>> antonymsMap();

  /// A hashmap of [PartOfSpeech] to definitions that are synonyms of [term].
  Map<PartOfSpeech, Set<String>> definitionsMap();

  /// A hashmap of [PartOfSpeech] to phrases using [term].
  Map<PartOfSpeech, Set<String>> phrasesMap();

  /// A hashmap of [PartOfSpeech] to inflections that are inflections of [term].
  Map<PartOfSpeech, Set<String>> inflectionsMap();

  /// Returns an unordered collection of unique definitions for [term].
  Set<String> allDefinitions();

  /// Returns an unordered collection of unique terms that are synonyms of
  /// [term].
  Set<String> allSynonyms();

  /// Returns an unordered collection of unique terms that are antonyms of
  /// [term].
  Set<String> allAntonyms();

  /// Returns an unordered collection of unique terms that are inflections of
  /// [term].
  Set<String> allInflections();

  /// An unordered collection of unique example phrases that include [term].
  Set<String> allPhrases();

  /// Returns a set of phrases for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> phrasesWith([PartOfSpeech? partOfSpeech]);

  /// Returns a set of inflections for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> inflectionsOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of definitions for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> definitionsFor([PartOfSpeech? partOfSpeech]);

  /// Returns a set of synonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> synonymsOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of antonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> antonymsOf([PartOfSpeech? partOfSpeech]);
}

/// Abstract mixin class that implements the `==` operator and methods of the
/// [TermProperties] interface.
/// - the `==` operator by comparing type and the [term], [languageCode] and
///   [variants] properties.
/// - [hashCode] returns an Object.hash of the [term], [languageCode] and
///   [variants] properties.
/// - [phrasesWith] maps [variants] to a set of phrases, optionally
///   limiting the maps [variants] to to the [PartOfSpeech].
/// - [inflectionsOf] maps [variants] to a set of inflections of [term],
///   optionally limiting the results to the [PartOfSpeech].
/// - [definitionsFor] maps [variants] to a set of definitions for [term],
///   optionally limiting the results to the [PartOfSpeech].
/// - [synonymsOf] maps [variants] to a set of synonyms of [term], optionally
///   limiting the results to the [PartOfSpeech].
/// - [antonymsOf] maps [variants] to a set of antonyms of [term], optionally
///   limiting the results to the [PartOfSpeech].
/// - [allAntonyms] maps all the antonyms from [variants] to a set.
/// - [allDefinitions] maps all the definitions from [variants] to a set.
/// - [allInflections] maps all the inflections from [variants] to a set.
/// - [allPhrases] maps all the phrases from [variants] to a set.
/// - [allSynonyms] maps all the synonyms from [variants] to a set.
/// - [antonymsMap] maps [PartOfSpeech] to antonyms from [variants].
/// - [definitionsMap] maps [PartOfSpeech] to definitions from [variants].
/// - [inflectionsMap] maps [PartOfSpeech] to inflections from [variants].
/// - [phrasesMap] maps [PartOfSpeech] to phrases from [variants].
/// - [synonymsMap] maps [PartOfSpeech] to synonyms from [variants].
///
/// Sub-classes must override:
/// - [languageCode], the ISO language code for the language of the [term];
/// - [variants], an un-ordered collection of unique [TermDefinition] instances;
/// - [term], the term or word for this [TermProperties];
/// - [lemma], the lemma of [term];
/// - [stem], the stemmed version of [term]; and
/// - [phonetic], the phonetic representation of [term] when pronounced in
///   [languageCode].
abstract class TermPropertiesMixin implements TermProperties {
  //

  @override
  Set<String> allAntonyms() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.antonyms);
    }
    return retVal;
  }

  @override
  Set<String> allDefinitions() => variants.map((e) => e.definition).toSet();

  @override
  Set<String> allInflections() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.inflections);
    }
    return retVal;
  }

  @override
  Set<String> allPhrases() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.phrases);
    }
    return retVal;
  }

  @override
  Set<String> allSynonyms() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.synonyms);
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> antonymsMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.antonyms);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> definitionsMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.add(e.definition);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> inflectionsMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.inflections);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> phrasesMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.phrases);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> synonymsMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.synonyms);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Set<String> phrasesWith([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allPhrases());
    } else {
      for (final e in phrasesMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
    }
    return retVal;
  }

  @override
  Set<String> definitionsFor([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allDefinitions());
    } else {
      for (final e in definitionsMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
    }
    return retVal;
  }

  @override
  Set<String> inflectionsOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allInflections());
    } else {
      for (final e in inflectionsMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
    }

    return retVal;
  }

  @override
  Set<String> synonymsOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allSynonyms());
    } else {
      for (final e in synonymsMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
    }
    return retVal;
  }

  @override
  Set<String> antonymsOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allAntonyms());
    } else {
      for (final e in antonymsMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
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

/// An abstract `base class` with [TermPropertiesMixin] that implements the
/// [TermProperties] interface.
///
/// Sub-classes of [TermPropertiesBase] must override:
/// - [languageCode], the ISO language code for the language of the [term];
/// - [variants], an un-ordered collection of unique [TermDefinition] instances;
/// - [term], the term or word for this [TermProperties];
/// - [lemma], the lemma of [term];
/// - [stem], the stemmed version of [term]; and
/// - [phonetic], the phonetic representation of [term] when pronounced in
///   [languageCode].
abstract class TermPropertiesBase with TermPropertiesMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const TermPropertiesBase();

  //
}

/// Implementation class for [TermProperties], extends [TermPropertiesBase].
class _TermPropertiesImpl extends TermPropertiesBase {
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

  const _TermPropertiesImpl(this.languageCode, this.term, this.stem, this.lemma,
      this.phonetic, this._variants);

  @override
  final String lemma;

  @override
  final String stem;

  @override
  final String phonetic;
}
