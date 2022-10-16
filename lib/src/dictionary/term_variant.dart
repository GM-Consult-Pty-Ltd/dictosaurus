// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// A definition for a defintion and/or part-of-speech variant of a term, used
/// in a [TermProperties] object.
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
  /// - [etymologies] is an unordered collectionof etymologoies of [term] .
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
          required PartOfSpeech partOfSpeech,
          required Set<String> etymologies,
          required Set<Pronunciation> pronunciations,
          required String definition,
          required Set<String> synonyms,
          required Set<String> antonyms,
          required Set<String> phrases,
          required Set<String> inflections,
          required Set<String> lemmas}) =>
      _TermVariant(term, partOfSpeech, pronunciations, definition, etymologies,
          synonyms, antonyms, inflections, phrases, lemmas);

  /// Returns a copy of the [TermVariant] instance updated properties.
  /// - [term] is a term or word.
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
  TermVariant copyWith(
      {String? term,
      PartOfSpeech? partOfSpeech,
      String? definition,
      Set<String>? etymologies,
      Set<String>? synonyms,
      Set<String>? antonyms,
      Set<String>? phrases,
      Set<String>? inflections,
      Set<String>? lemmas});

  /// The term for this entry.
  String get term;

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
          PartOfSpeech? partOfSpeech,
          Set<Pronunciation>? pronunciations,
          String? definition,
          Set<String>? etymologies,
          Set<String>? synonyms,
          Set<String>? antonyms,
          Set<String>? phrases,
          Set<String>? inflections,
          Set<String>? lemmas}) =>
      _TermVariant(
          term ?? this.term,
          partOfSpeech ?? this.partOfSpeech,
          pronunciations ?? this.pronunciations,
          definition ?? this.definition,
          etymologies ?? this.etymologies,
          synonyms ?? this.synonyms,
          antonyms ?? this.antonyms,
          inflections ?? this.inflections,
          phrases ?? this.phrases,
          lemmas ?? this.lemmas);

  @override
  final String definition;

  @override
  final PartOfSpeech partOfSpeech;

  @override
  final Set<Pronunciation> pronunciations;

  @override
  final String term;

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
