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
abstract class DictoSaurus {
  //

  /// Initializes a [DictoSaurus] with [autoCorrect] and [dictionary] instances.
  factory DictoSaurus(
          {required Dictionary dictionary, required AutoCorrect autoCorrect}) =>
      _DictoSaurusImpl(autoCorrect, dictionary);

  /// Returns the meaning of [term].
  Future<DictionaryEntry?> getEntry(Term term);

  /// Returns the synonyms of [term] and its tokenized versions.
  Future<Set<String>> synonymsOf(String term);

  /// Returns a set of unique alternative spellings for a [term].
  ///
  /// If [limit] is not null, only the best [limit] matches will be returned.
  Future<Map<String, List<String>>> suggestionsFor(String term, [int limit]);

  /// Returns a set of unique terms that start with [chars].
  Future<List<String>> startsWith(String chars);

  /// Expands [term] to an ordered list of terms.
  ///
  /// If [term] exists in the dictionary, the returned list will include
  /// the [term] and then its synonyms.
  ///
  /// If [term] is not found in the dictionary, terms with similar spellings
  /// will be returned, ordered in descending order of relevance (i.e. best
  /// match first).
  ///
  /// If [limit] is not null, only the first [limit] terms will be returned.
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

/// A mixin class that implements [DictoSaurus.getEntry],
/// [DictoSaurus.synonymsOf], [DictoSaurus.suggestionsFor] and
/// [DictoSaurus.expandTerm].
///
/// Implementations that mix in [DictoSaurusMixin] must override:
/// - [dictionary] is ;
abstract class DictoSaurusMixin implements DictoSaurus {
  //

  /// A [Dictionary] instance used by [getEntry].
  Dictionary get dictionary;

  /// A [AutoCorrect] instance used by [suggestionsFor].
  AutoCorrect get autoCorrect;

  @override
  Future<List<String>> expandTerm(String term, [int limit = 5]) async {
    final retVal = <Term>[];
    final entry = await dictionary.getEntry(term);
    if (entry != null) {
      retVal.add(term);
      retVal.addAll(entry.allSynonyms);
    } else {
      final suggestions = await autoCorrect.suggestionsFor(term, limit);
      for (final s in suggestions.values) {
        retVal.addAll(s);
      }
    }
    return (retVal.length > limit) ? retVal.sublist(0, limit) : retVal;
  }

  @override
  Future<DictionaryEntry?> getEntry(Term term) => dictionary.getEntry(term);

  @override
  Future<Set<String>> synonymsOf(String term) async =>
      (await getEntry(term))?.allSynonyms ?? {};

  @override
  Future<List<String>> startsWith(String chars) =>
      autoCorrect.startsWith(chars);

  @override
  Future<Map<String, List<String>>> suggestionsFor(String term,
          [int limit = 10]) =>
      autoCorrect.suggestionsFor(term, limit);
}

/// A [DictoSaurus] with final [autoCorrect] and [dictionary] fields and
/// a generative constructor.
class _DictoSaurusImpl extends DictoSaurusBase {
  //

  @override
  final AutoCorrect autoCorrect;

  @override
  final Dictionary dictionary;

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [dictionary] instances.
  const _DictoSaurusImpl(this.autoCorrect, this.dictionary);
}
