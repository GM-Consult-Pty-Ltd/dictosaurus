// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// An `object model` for a `term` or `word` with immutable properties.
///
/// The folling fields enumerate the object properties:
/// - [term] is the term or word for this entry;
/// - [stem] is the stemmed version of [term];
/// - [language] is the [Language] of the [term];
/// - [variants] is an un-ordered collection of unique [TermVariant]
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
///   the results to the [PartOfSpeech];///
/// - [pronunciationsOf] returns a set of [Pronunciation]s of [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [lemmasOf] returns a set of lemmas of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [antonymsOf] returns a set of antonyms of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [allAntonyms] maps all the antonyms to a set;
/// - [allDefinitions] maps all the definitions to a set;
/// - [allInflections] maps all the inflections to a set;
/// - [allPhrases] maps all the phrases to a set;
/// - [allSynonyms] maps all the synonyms to a set;
/// - [allPronunciations] maps all the [Pronunciation]s to a set;
/// - [allLemmas] maps all the lemmas to a set;
/// - [antonymsMap] maps [PartOfSpeech] to antonyms;
/// - [definitionsMap] maps [PartOfSpeech] to definitions;
/// - [inflectionsMap] maps [PartOfSpeech] to inflections;
/// - [phrasesMap] maps [PartOfSpeech] to phrases;
/// - [lemmasMap] maps [PartOfSpeech] to lemmas;
/// - [synonymsMap] maps [PartOfSpeech] to synonyms; and
/// - [pronunciationsMap] maps [PartOfSpeech] to [Pronunciation]s.
abstract class TermProperties {
  //

  /// A factory constructor that instantiates an immutable [TermProperties]
  /// instance.
  /// - [language] is the [Language] of the [term].
  /// - [term] is the term or word for this [TermProperties].
  /// - [stem] is the stemmed version of [term].
  /// - [variants] is an un-ordered collection of unique [TermVariant]
  ///   instances.
  ///
  /// The [variants] field of the implementation class is immutable as it
  /// returns a copy of a private variable.
  factory TermProperties(
          {required String term,
          required String stem,
          required Language language,
          required Iterable<TermVariant> variants}) =>
      _TermPropertiesImpl(language, term, stem, variants.toSet());

  /// The language of the [term].
  ///
  /// See https://en.wikipedia.org/wiki/IETF_language_tag.
  Language get language;

  /// The term for this [TermProperties].
  String get term;

  /// The stemmed version of [term].
  String get stem;

  /// An un-ordered collection of unique [TermVariant] instances.
  Set<TermVariant> get variants;

  /// A hashmap of [PartOfSpeech] to etymologies of [term].
  Map<PartOfSpeech, Set<String>> etymologiesMap();

  /// A hashmap of [PartOfSpeech] to terms that are synonyms of [term].
  Map<PartOfSpeech, Set<String>> synonymsMap();

  /// A hashmap of [PartOfSpeech] to [Pronunciation]s of [term].
  Map<PartOfSpeech, Set<Pronunciation>> pronunciationsMap();

  /// A hashmap of [PartOfSpeech] to terms that are lemmas of [term].
  Map<PartOfSpeech, Set<String>> lemmasMap();

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

  /// Returns an unordered collection of etymologies of [term].
  Set<String> allEtymologies();

  /// Returns an unordered collection of unique terms that are synonyms of
  /// [term].
  Set<String> allSynonyms();

  /// Returns an unordered collection of [Pronunciation]s of [term].
  Set<Pronunciation> allPronunciations();

  /// Returns an unordered collection of unique terms that are lemmas of
  /// [term].
  Set<String> allLemmas();

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

  /// Returns a set of etymologies for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> etymologiesOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of synonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> synonymsOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of [Pronunciation]s of [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<Pronunciation> pronunciationsOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of lemmas for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> lemmasOf([PartOfSpeech? partOfSpeech]);

  /// Returns a set of antonyms for [term] from a dictionary provider.
  ///
  /// Limit results by providing the [partOfSpeech].
  Set<String> antonymsOf([PartOfSpeech? partOfSpeech]);
}

/// Abstract mixin class that implements the `==` operator and methods of the
/// [TermProperties] interface.
/// - the `==` operator by comparing type and the [term], [language] and
///   [variants] properties.
/// - [hashCode] returns an Object.hash of the [term], [language] and
///   [variants] properties.
/// - [phrasesWith] returns a set of phrases containing [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [inflectionsOf] returns a set of inflections of [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [definitionsFor] returns a set of definitions for [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [etymologiesOf] returns a set of etymologies of [term], optionally
///   limiting the results to the [PartOfSpeech];
/// - [synonymsOf] returns a set of synonyms of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [pronunciationsOf] returns a set of [Pronunciation]s of [term],
///   optionally limiting the results to the [PartOfSpeech];
/// - [lemmasOf] returns a set of lemmas of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [antonymsOf] returns a set of antonyms of [term], optionally limiting
///   the results to the [PartOfSpeech];
/// - [allAntonyms] maps all the antonyms to a set;
/// - [allDefinitions] maps all the definitions to a set;
/// - [allInflections] maps all the inflections to a set;
/// - [allPhrases] maps all the phrases to a set;
/// - [allEtymologies] maps all the etymologies to a set;
/// - [allSynonyms] maps all the synonyms to a set;
/// - [allPronunciations] maps all the [Pronunciation]s to a set;
/// - [allLemmas] maps all the lemmas to a set;
/// - [antonymsMap] maps [PartOfSpeech] to antonyms;
/// - [definitionsMap] maps [PartOfSpeech] to definitions;
/// - [inflectionsMap] maps [PartOfSpeech] to inflections;
/// - [phrasesMap] maps [PartOfSpeech] to phrases;
/// - [lemmasMap] maps [PartOfSpeech] to lemmas;
/// - [etymologiesMap] maps [PartOfSpeech] to etymologies;
/// - [synonymsMap] maps [PartOfSpeech] to synonyms; and
/// - [pronunciationsMap] maps [PartOfSpeech] to [Pronunciation]s.
///
/// Sub-classes must override:
/// - [language], the [Language] of the [term];
/// - [variants], an un-ordered collection of unique [TermVariant] instances;
/// - [term], the term or word for this [TermProperties]; and
/// - [stem], the stemmed version of [term].
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
  Set<String> allEtymologies() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.etymologies);
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
  Set<Pronunciation> allPronunciations() {
    final Set<Pronunciation> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.pronunciations);
    }
    return retVal;
  }

  @override
  Set<String> allLemmas() {
    final Set<String> retVal = {};
    for (final e in variants) {
      retVal.addAll(e.lemmas);
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
  Map<PartOfSpeech, Set<String>> etymologiesMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.etymologies);
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
  Map<PartOfSpeech, Set<Pronunciation>> pronunciationsMap() {
    final Map<PartOfSpeech, Set<Pronunciation>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.pronunciations);
      retVal[e.partOfSpeech] = value;
    }
    return retVal;
  }

  @override
  Map<PartOfSpeech, Set<String>> lemmasMap() {
    final Map<PartOfSpeech, Set<String>> retVal = {};
    for (final e in variants) {
      final value = retVal[e.partOfSpeech] ?? {};
      value.addAll(e.lemmas);
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
  Set<String> etymologiesOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allEtymologies());
    } else {
      for (final e in etymologiesMap().entries) {
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
  Set<Pronunciation> pronunciationsOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <Pronunciation>{};
    if (partOfSpeech == null) {
      retVal.addAll(allPronunciations());
    } else {
      for (final e in pronunciationsMap().entries) {
        if (e.key == partOfSpeech) {
          retVal.addAll(e.value);
        }
      }
    }
    return retVal;
  }

  @override
  Set<String> lemmasOf([PartOfSpeech? partOfSpeech]) {
    final retVal = <String>{};
    if (partOfSpeech == null) {
      retVal.addAll(allLemmas());
    } else {
      for (final e in lemmasMap().entries) {
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
      language == other.language &&
      variants.intersection(other.variants).length == variants.length;

  @override
  int get hashCode => Object.hash(term, language, variants);
}

/// An abstract `base class` with [TermPropertiesMixin] that implements the
/// [TermProperties] interface.
///
/// Sub-classes of [TermPropertiesBase] must override:
/// - [language], the [Language] of the [term];
/// - [variants], an un-ordered collection of unique [TermVariant] instances;
/// - [term], the term or word for this [TermProperties]; and
/// - [stem], the stemmed version of [term].
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
  final Set<TermVariant> _variants;

  /// An un-ordered collection of unique [TermVariant] instances.
  @override
  Set<TermVariant> get variants => Set<TermVariant>.from(_variants);

  @override
  final Language language;

  @override
  final String term;

  const _TermPropertiesImpl(
      this.language, this.term, this.stem, this._variants);

  @override
  final String stem;
}
