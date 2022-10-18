// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// A definition for a defintion and/or part-of-speech variant of a term, used
/// in a [DictionaryEntry] object.
/// - [term] is a term or word.
/// - [partOfSpeech] is the [PartOfSpeech] category of the [term].
/// - [pronunciations] is the phonetic spelling of and a link to an
///   audiofile for the pronunciations of the [term].
/// - [definition] is the definition for [term] when used as [partOfSpeech].
/// - [synonyms] is an unordered collection synonyms for [term].
/// - [etymologies] is an unordered collectionof etymologoies of [term] .
/// - [antonyms] is an unordered collection antonyms for [term].
/// - [inflections] is an unordered collection of inflections of [term].
/// - [lemmas], the lemmas of [term].
/// - [phrases] is an unordered collection of unique example phrases that
///   include [term] when used as [partOfSpeech].
abstract class TermVariant {
  //

  /// A factory constructor that instantiates an immutable [TermVariant]
  /// object.
  /// - [term] is a term or word.
  /// - [partOfSpeech] is the [PartOfSpeech] category of the [term].
  /// - [pronunciations] is the phonetic spelling of and a link to an
  ///   audiofile for the pronunciations of the [term].
  /// - [definition] is the definition for [term] when used as [partOfSpeech].
  /// - [synonyms] is an unordered collection synonyms for [term].
  /// - [etymologies] is an unordered collectionof etymologies of [term] .
  /// - [antonyms] is an unordered collection antonyms for [term].
  /// - [inflections] is an unordered collection of inflections of [term].
  /// - [lemmas], the lemmas of [term].
  /// - [phrases] is an unordered collection of unique example phrases that
  ///   include [term] when used as [partOfSpeech].
  ///
  /// *NOTE: the `== operator` compares only the [term], [partOfSpeech] and
  /// [definition] properties.*
  factory TermVariant(
          {required String term,
          required Language language,
          required String definition,
          required PartOfSpeech partOfSpeech,
          Set<String> etymologies = const <String>{},
          Set<Pronunciation> pronunciations = const <Pronunciation>{},
          Set<String> synonyms = const <String>{},
          Set<String> antonyms = const <String>{},
          Set<String> phrases = const <String>{},
          Set<String> inflections = const <String>{},
          Set<String> lemmas = const <String>{}}) =>
      _TermVariant(term, language, partOfSpeech, pronunciations, definition,
          etymologies, synonyms, antonyms, inflections, phrases, lemmas);

  /// Returns a copy of the [TermVariant] instance updated properties.
  /// - [term] is a term or word.
  /// - [term] is a term or word.
  /// - [language] is the [Language] of the term  variant.
  /// - [partOfSpeech] is the [PartOfSpeech] category of the [term].
  /// - [pronunciations] is the phonetic spelling of and a link to an
  ///   audiofile for the pronunciations of the [term].
  /// - [definition] is the definition for [term] when used as [partOfSpeech].
  /// - [synonyms] is an unordered collection synonyms for [term].
  /// - [etymologies] is an unordered collectionof etymologoies of [term] .
  /// - [antonyms] is an unordered collection antonyms for [term].
  /// - [inflections] is an unordered collection of inflections of [term].
  /// - [lemmas], the lemmas of [term].
  /// - [phrases] is an unordered collection of unique example phrases that
  ///   include [term] when used as [partOfSpeech].
  TermVariant copyWith(
      {String? term,
      Language? language,
      PartOfSpeech? partOfSpeech,
      String? definition,
      Iterable<Pronunciation>? pronunciations,
      Iterable<String>? etymologies,
      Iterable<String>? synonyms,
      Iterable<String>? antonyms,
      Iterable<String>? phrases,
      Iterable<String>? inflections,
      Iterable<String>? lemmas});

  /// The term for this entry.
  String get term;

  /// The [Language] of the term  variant.
  Language get language;

  /// The [PartOfSpeech] category of the [term].
  PartOfSpeech get partOfSpeech;

  /// The term variant's phonetic spelling and a link to an audiofile for its
  /// pronunciations.
  Set<Pronunciation> get pronunciations;

  /// The definition for [term] when used as [partOfSpeech].
  String get definition;

  /// An unordered collection of unique terms that are synonyms of [term] when
  /// used as [partOfSpeech].
  Set<String> get synonyms;

  /// An unordered collection of etymologoies of [term] when used as
  /// [partOfSpeech].
  Set<String> get etymologies;

  /// An unordered collection of unique terms that are antonyms of [term] when
  /// used as [partOfSpeech].
  Set<String> get antonyms;

  /// An unordered collection of unique terms that are inflections of [term]
  /// when used as [partOfSpeech].
  Set<String> get inflections;

  /// An unordered collection of unique terms that are inflections of [term]
  /// when used as [partOfSpeech].
  Set<String> get lemmas;

  /// An unordered collection of unique example phrases that include [term]
  /// when used as [partOfSpeech].
  Set<String> get phrases;

  // Map<String, String> get translations;
}

/// Abstract implementation class of [TermVariant] that implements the
/// `==` operator and [hashCode].
///
/// *NOTE: the `== operator` compares only the [term], [partOfSpeech] and
/// [definition] properties.*
abstract class TermVariantBase with TermVariantMixin {
//

  /// Default const generative constructor for sub-classes.
  const TermVariantBase();
}

/// Abstract mixin class of [TermVariant] that implements the
/// `==` operator and [hashCode].
///
/// *NOTE: the `== operator` compares only the [term], [partOfSpeech] and
/// [definition] properties.*
abstract class TermVariantMixin implements TermVariant {
//
  /// Compares only the [term], [partOfSpeech] and [definition] properties.
  @override
  bool operator ==(Object other) =>
      other is TermVariant &&
      term == other.term &&
      partOfSpeech == other.partOfSpeech &&
      definition == other.definition;

  @override
  int get hashCode => Object.hash(term, partOfSpeech, definition);
}

class _TermVariant extends TermVariantBase {
  //

  const _TermVariant(
      this.term,
      this.language,
      this.partOfSpeech,
      this.pronunciations,
      this.definition,
      this.etymologies,
      this.synonyms,
      this.antonyms,
      this.inflections,
      this.phrases,
      this.lemmas);

  @override
  TermVariant copyWith(
          {String? term,
          Language? language,
          PartOfSpeech? partOfSpeech,
          String? definition,
          Iterable<Pronunciation>? pronunciations,
          Iterable<String>? etymologies,
          Iterable<String>? synonyms,
          Iterable<String>? antonyms,
          Iterable<String>? phrases,
          Iterable<String>? inflections,
          Iterable<String>? lemmas}) =>
      _TermVariant(
          term ?? this.term,
          language ?? this.language,
          partOfSpeech ?? this.partOfSpeech,
          pronunciations?.toSet() ?? this.pronunciations,
          definition ?? this.definition,
          etymologies?.toSet() ?? this.etymologies,
          synonyms?.toSet() ?? this.synonyms,
          antonyms?.toSet() ?? this.antonyms,
          inflections?.toSet() ?? this.inflections,
          phrases?.toSet() ?? this.phrases,
          lemmas?.toSet() ?? this.lemmas);

  @override
  final String definition;

  @override
  final PartOfSpeech partOfSpeech;

  @override
  final Set<Pronunciation> pronunciations;

  @override
  final String term;

  @override
  final Language language;

  @override
  final Set<String> phrases;

  @override
  final Set<String> lemmas;

  @override
  final Set<String> antonyms;

  @override
  final Set<String> inflections;

  @override
  final Set<String> etymologies;

  @override
  final Set<String> synonyms;
}
