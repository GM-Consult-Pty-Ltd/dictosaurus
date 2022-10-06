// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'part_of_speech.dart';

/// A definition for a term, used in a [DictionaryEntry] object with immutable
/// properties:
/// - [term] is a term or word;
/// - [partOfSpeech] is the [PartOfSpeech] category of the [term];
/// - [definition] is the definition for [term] when used as [partOfSpeech];
/// - [synonyms] is an unordered collection of unique terms that are synonyms
///   of [term] when used as [partOfSpeech];
/// - [antonyms] is an unordered collection of unique terms that are antonyms
///   of [term] when used as [partOfSpeech];
/// - [inflections] is an unordered collection of unique terms that are
///   inflections of [term] when used as [partOfSpeech]; and
/// - [phrases] is an unordered collection of unique example phrases that
///   include [term] when used as [partOfSpeech].
abstract class TermVariant {
  //

  /// Factory constructor instantiates an immutable [TermVariant] object
  /// with the following parameters:
  /// - [term] is a term or word;
  /// - [partOfSpeech] is the [PartOfSpeech] category of the [term];
  /// - [definition] is the definition for [term] when used as [partOfSpeech];
  /// - [synonyms] is an unordered collection of unique terms that are synonyms
  ///   of [term] when used as [partOfSpeech];
  /// - [antonyms] is an unordered collection of unique terms that are antonyms
  ///   of [term] when used as [partOfSpeech]; and
  /// - [inflections] is an unordered collection of unique terms that are
  ///   inflections of [term] when used as [partOfSpeech]; and
  /// - [phrases] is an unordered collection of unique example phrases that
  ///   include [term] when used as [partOfSpeech].
  ///
  /// *NOTE: the `== operator` compares only the [term], [partOfSpeech] and
  /// [definition] properties.*
  factory TermVariant(
          {required String term,
          required PartOfSpeech partOfSpeech,
          required String definition,
          required Set<String> synonyms,
          required Set<String> antonyms,
          required Set<String> phrases,
          required Set<String> inflections}) =>
      _TermVariant(term, partOfSpeech, definition, synonyms, antonyms,
          inflections, phrases);

  /// The term for this entry.
  String get term;

  /// The [PartOfSpeech] category of the [term].
  PartOfSpeech get partOfSpeech;

  /// The definition for [term] when used as [partOfSpeech].
  String get definition;

  /// An unordered collection of unique terms that are synonyms of [term] when
  /// used as [partOfSpeech].
  Set<String> get synonyms;

  /// An unordered collection of unique terms that are antonyms of [term] when
  /// used as [partOfSpeech].
  Set<String> get antonyms;

  /// An unordered collection of unique terms that are inflections of [term]
  /// when used as [partOfSpeech].
  Set<String> get inflections;

  /// An unordered collection of unique example phrases that include [term]
  /// when used as [partOfSpeech].
  Set<String> get phrases;
}

/// Abstract implementation class of [TermVariant] that implements the
/// `==` operator and [hashCode].
///
/// *NOTE: the `== operator` compares only the [term], [partOfSpeech] and
/// [definition] properties.*
abstract class TermVariantBase implements TermVariant {
//

  /// Default const generative constructor for sub-classes.
  const TermVariantBase();

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

  @override
  final String definition;

  @override
  final PartOfSpeech partOfSpeech;

  @override
  final String term;

  const _TermVariant(this.term, this.partOfSpeech, this.definition,
      this.synonyms, this.antonyms, this.inflections, this.phrases);

  @override
  final Set<String> phrases;

  @override
  final Set<String> antonyms;

  @override
  final Set<String> inflections;

  @override
  final Set<String> synonyms;
}
