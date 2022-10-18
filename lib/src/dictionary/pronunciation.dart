// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// Object model for a [term] variant's pronunciation.
/// - [term] is a term or word.
/// - [dialect] is the pronunciation version of the term.
/// - [phoneticSpelling] is the phonetic spelling of a term variant using
///   the International Phonetic Alphabet (IPA).
/// - [audioLink] is a link to an audio file for the pronunciation.
abstract class Pronunciation {
  //

  /// The term for this entry.
  String get term;

  /// The pronunciation version of the term (e.g. "Australian").
  String get dialect;

  /// The phonetic spelling of the term variant using the International
  /// Phonetic Alphabet (IPA).
  ///
  /// See https://en.wikipedia.org/wiki/Phonetic_transcription.
  String get phoneticSpelling;

  /// Link to an audio file for the pronunciation.
  String get audioLink;

  /// Factory constructor returns a [Pronunciation] instance.
  /// - [term] is a term or word.
  /// - [dialect] is the pronunciation version of the term.
  /// - [phoneticSpelling] is the phonetic spelling of a term variant using
  ///   the International Phonetic Alphabet (IPA).
  /// - [audioLink] is a link to an audio file for the pronunciation.
  factory Pronunciation(
          {required String term,
          required String phoneticSpelling,
          required String dialect,
          String? audioLink}) =>
      _PronunciationImpl(term, dialect, phoneticSpelling, audioLink ?? '');

  /// Returns a copy of the [Pronunciation] instance with updated properties.
  /// - [term] is a term or word.
  /// - [phoneticSpelling] is the phonetic spelling of a term variant using
  ///   the International Phonetic Alphabet (IPA).
  /// - [audioLink] is a link to an audio file for the pronunciation.
  Pronunciation copyWith(
      {String? term,
      String? dialect,
      String? phoneticSpelling,
      String? audioLink});

  /// A const [Pronunciation] instance with empty properties.
  static const empty = _PronunciationImpl('', '', '', '');
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
  final String dialect;

  const _PronunciationImpl(
      this.term, this.dialect, this.phoneticSpelling, this.audioLink);

  @override
  _PronunciationImpl copyWith(
          {String? term,
          String? dialect,
          String? phoneticSpelling,
          String? audioLink}) =>
      _PronunciationImpl(
          term ?? this.term,
          dialect ?? this.dialect,
          phoneticSpelling ?? this.phoneticSpelling,
          audioLink ?? this.audioLink);
}
