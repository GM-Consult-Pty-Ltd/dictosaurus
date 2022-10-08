// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [DictoSaurus] composition class combines a [Dictionary],
/// [Thesaurus] and [AutoCorrect] which it uses to expose the following
/// methods:
/// - [getEntry] returns the meaning of a term from a dictionary provider;
/// - [synonymsOf] returns the synonyms of a term from a [Set<String>];
/// - [suggestionsFor] returns alternative spellings for a term;
/// - [startsWith] returns terms from a [KGramsMap] that start with a sequence
///   of characters; and
/// - [expandTerm] expands a term using [synonymsOf] and [suggestionsFor].
abstract class DictoSaurus implements Dictionary, Thesaurus, AutoCorrect {
  //

  /// Initializes a [DictoSaurus] with [autoCorrect] and [dictionary] instances.
  factory DictoSaurus(
          {required Dictionary dictionary, required AutoCorrect autoCorrect}) =>
      _DictoSaurusImpl(dictionary, autoCorrect);

  /// Expands [term] to an ordered list of terms.
  ///
  /// The returned list always has [term] as its first element.
  ///
  /// Any synonyms returned by the dictionary provider are added to the list.
  ///
  /// If the length of the list is less than [limit], terms with similar
  /// spellings will be added, ordered in descending order of relevance (i.e.
  /// best match first).
  ///
  /// Only the first [limit] terms will be returned.
  Future<List<String>> expandTerm(String term, [int limit]);
}

/// Implements [DictoSaurus] by mixing in [DictoSaurusMixin].
///
/// Sub-classes must override:
/// - [autoCorrect] a [AutoCorrect] instance used by [suggestionsFor] and
///   [startsWith];
/// - [dictionary] a [Dictionary] instance used by [getEntry].
///
abstract class DictoSaurusBase with DictoSaurusMixin {
  /// A const generative constructor for sub classes.
  const DictoSaurusBase();
}

/// A mixin class that implements the [Dictionary], [Thesaurus] and
/// [AutoCorrect] interface methods as well as [DictoSaurus.expandTerm].
///
/// Implementations that mix in [DictoSaurusMixin] must override [dictionary],
/// [autoCorrect] and [Thesaurus].
abstract class DictoSaurusMixin implements DictoSaurus {
  //

  /// A [Thesaurus] instance used by [getEntry].
  Thesaurus get thesaurus;

  /// A [AutoCorrect] instance used by [suggestionsFor].
  AutoCorrect get autoCorrect;

  /// A [Dictionary] instance used by [getEntry].
  Dictionary get dictionary;

  @override
  String get languageCode => dictionary.languageCode;

  @override
  Future<Set<String>> synonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      thesaurus.synonymsOf(term, partOfSpeech);

  @override
  Future<Set<String>> antonymsOf(String term, [PartOfSpeech? partOfSpeech]) =>
      thesaurus.synonymsOf(term, partOfSpeech);

  @override
  Future<Set<String>> inflectionsOf(String term,
          [PartOfSpeech? partOfSpeech]) =>
      dictionary.inflectionsOf(term, partOfSpeech);

  @override
  Future<Set<String>> phrasesWith(String term, [PartOfSpeech? partOfSpeech]) =>
      dictionary.phrasesWith(term, partOfSpeech);

  @override
  Future<Set<String>> definitionsFor(String term,
          [PartOfSpeech? partOfSpeech]) =>
      dictionary.definitionsFor(term, partOfSpeech);

  @override
  Future<List<String>> expandTerm(String term, [int limit = 5]) async {
    final retVal = <String>{term};
    final entry = await dictionary.getEntry(term);
    if (entry != null) {
      retVal.add(term);
      retVal
          .addAll(entry.allSynonyms.where((element) => !element.contains(' ')));
    }
    if (retVal.length < limit) {
      final suggestions = await autoCorrect.suggestionsFor(term, limit);
      retVal.addAll(suggestions);
    }
    final list = retVal.toList();
    return (list.length > limit) ? list.sublist(0, limit) : list;
  }

  @override
  Future<TermProperties?> getEntry(Term term) => dictionary.getEntry(term);

  @override
  Future<List<String>> startsWith(String chars, [int limit = 10]) =>
      autoCorrect.startsWith(chars, limit);

  @override
  Future<List<String>> suggestionsFor(String term, [int limit = 10]) =>
      autoCorrect.suggestionsFor(term, limit);
}

/// A [DictoSaurus] with final [autoCorrect] and [dictionary] fields and
/// a generative constructor.
class _DictoSaurusImpl extends DictoSaurusBase {
  //

  @override
  final AutoCorrect autoCorrect;

  @override
  Thesaurus get thesaurus => Thesaurus.dictionary(dictionary);

  @override
  final Dictionary dictionary;

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [dictionary] instances.
  const _DictoSaurusImpl(this.dictionary, this.autoCorrect);
}
