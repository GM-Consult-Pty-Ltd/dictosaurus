// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';
import 'term_variant.dart';

/// Object model for an entry in a [Dictionary] with immutable properties:
/// - [term] is the term or word for this entry;
/// - [stem] is the stemmed version of [term];
/// - [lemma] is the lemma of [term];
/// - [languageCode] is the ISO language code for the language of the
///   [term]; and
/// - [variants] is an un-ordered collection of unique [TermVariant]
///   instances.
abstract class DictionaryEntry {
  //

  /// Factory constructor that instantiates an immutable [DictionaryEntry]
  /// instance:
  /// - [languageCode] is the ISO language code for the language of the
  ///   [term];
  /// - [term] is the term or word for this entry;
  /// - [stem] is the stemmed version of [term];
  /// - [lemma] is the lemma of [term];
  /// - [phonetic] is the phonetic representation of [term] when pronounced in
  ///   [languageCode]; and
  /// - [variants] is an un-ordered collection of unique [TermVariant]
  ///   instances.
  ///
  /// The [variants] field of the implementation class is immutable as it
  /// returns a copy of a private variable.
  factory DictionaryEntry(
          {required String term,
          required String stem,
          required String lemma,
          required String phonetic,
          required String languageCode,
          required Iterable<TermVariant> variants}) =>
      _DictionaryEntry(
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

  /// An un-ordered collection of unique [TermVariant] instances.
  Set<TermVariant> get variants;
}

/// Abstract implementation class of [DictionaryEntry] that implements the
/// `==` operator and [hashCode].
abstract class DictionaryEntryBase implements DictionaryEntry {
  //

  /// Default const generative constructor for sub-classes.
  const DictionaryEntryBase();

  @override
  bool operator ==(Object other) =>
      other is DictionaryEntry &&
      term == other.term &&
      languageCode == other.languageCode &&
      variants.intersection(other.variants).length == variants.length;

  @override
  int get hashCode => Object.hash(term, languageCode, variants);
}

/// Implementation class for [DictionaryEntry], extends [DictionaryEntryBase].
class _DictionaryEntry extends DictionaryEntryBase {
  //

  /// Private final field for [variants].
  final Set<TermVariant> _variants;

  /// An un-ordered collection of unique [TermVariant] instances.
  @override
  Set<TermVariant> get variants => Set<TermVariant>.from(_variants);

  @override
  final String languageCode;

  @override
  final String term;

  const _DictionaryEntry(this.languageCode, this.term, this.stem, this.lemma,
      this.phonetic, this._variants);

  @override
  final String lemma;

  @override
  final String stem;

  @override
  final String phonetic;
}
