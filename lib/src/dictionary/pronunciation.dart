// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// Object model for a [term] variant's pronunciation.
/// - [term] is a term or word.
/// - [phoneticSpelling] is the phonetic spelling of a term variant using
///   the International Phonetic Alphabet (IPA).
/// - [audioLink] is a link to an audio file for the pronunciation.
abstract class Pronunciation {
  //

  /// The term for this entry.
  String get term;

  /// The IETF BCP 47 language tags of the pronunciation.
  ///
  /// See https://en.wikipedia.org/wiki/IETF_language_tag.
  Set<String> get languageCodes;

  /// The phonetic spelling of the term variant using the International
  /// Phonetic Alphabet (IPA).
  ///
  /// See https://en.wikipedia.org/wiki/Phonetic_transcription.
  String get phoneticSpelling;

  /// Link to an audio file for the pronunciation.
  String get audioLink;

  /// Factory constructor returns a [Pronunciation] instance.
  /// - [term] is a term or word.
  /// - [phoneticSpelling] is the phonetic spelling of a term variant using
  ///   the International Phonetic Alphabet (IPA).
  /// - [audioLink] is a link to an audio file for the pronunciation.
  factory Pronunciation(
          {String? term,
          Iterable<String>? languageCodes,
          String? phoneticSpelling,
          String? audioLink}) =>
      _PronunciationImpl(term ?? '', languageCodes?.toSet() ?? {},
          phoneticSpelling ?? '', audioLink ?? '');

  /// Returns a copy of the [Pronunciation] instance with updated properties.
  /// - [term] is a term or word.
  /// - [phoneticSpelling] is the phonetic spelling of a term variant using
  ///   the International Phonetic Alphabet (IPA).
  /// - [audioLink] is a link to an audio file for the pronunciation.
  Pronunciation copyWith(
      {String? term,
      Iterable<String>? languageCodes,
      String? phoneticSpelling,
      String? audioLink});

  /// A const [Pronunciation] instance with empty properties.
  static const empty = _PronunciationImpl('', {}, '', '');
}

/// Abstract/mixin class implements [Pronunciation].
abstract class PronunciationMixin implements Pronunciation {
  //

  /// Compares the type, [term], [audioLink] and [phoneticSpelling]
  /// properties.
  @override
  bool operator ==(Object other) =>
      other is Pronunciation &&
      term == other.term &&
      audioLink == other.audioLink &&
      phoneticSpelling == other.phoneticSpelling;

  @override
  int get hashCode => Object.hash(term, audioLink, phoneticSpelling);
}

/// Abstract base class with [PronunciationMixin].
abstract class PronunciationBase with PronunciationMixin {
  /// Const default generative constructor.
  const PronunciationBase();
}

/// Implementation class for [Pronunciation] factories.
class _PronunciationImpl extends PronunciationBase {
  //

  @override
  final String term;

  @override
  final String phoneticSpelling;

  @override
  final String audioLink;

  @override
  final Set<String> languageCodes;

  const _PronunciationImpl(
      this.term, this.languageCodes, this.phoneticSpelling, this.audioLink);

  @override
  _PronunciationImpl copyWith(
          {String? term,
          Iterable<String>? languageCodes,
          String? phoneticSpelling,
          String? audioLink}) =>
      _PronunciationImpl(
          term ?? this.term,
          languageCodes?.toSet() ?? this.languageCodes,
          phoneticSpelling ?? this.phoneticSpelling,
          audioLink ?? this.audioLink);
}
