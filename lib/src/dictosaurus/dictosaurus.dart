// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [DictoSaurus] interface implements the [Dictionary], [Thesaurus] and
/// [AutoCorrect] interfaces.
///
/// The [DictoSaurus] interface also exposes the [DictoSaurus.expandTerm]
/// method that performs `term-expansion`, returning a list of terms in
/// descending order of relevance (best match first). The (expanded) list of
/// terms includes the `term`, its `synonyms` (if any) and spelling correction
/// suggestions.
abstract class DictoSaurus implements Dictionary, Thesaurus, AutoCorrect {
  //

  /// Initializes a [DictoSaurus] with [autoCorrect] and [dictionary] instances.
  factory DictoSaurus.fromComponents(
          {required Dictionary dictionary,
          required AutoCorrectBase autoCorrect}) =>
      _DictoSaurusFromComponentsImpl(dictionary, autoCorrect);

  /// Initializes a [DictoSaurus] with [languageCode], [k]-gram length and
  /// [kGramIndexLoader].
  factory DictoSaurus(
          {required DictionaryCallback dictionaryCallback,
          required Future<Map<String, Set<String>>> Function(
                  Iterable<String> terms)
              kGramIndexLoader,
          String languageCode = 'en_us',
          int k = 2}) =>
      _DictoSaurusImpl(kGramIndexLoader, dictionaryCallback, k, languageCode);

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
/// - [languageCode], the IETF BCP 47 language tag for the language of a term;
/// - [getEntry], a function that returns a [TermProperties] for a term;
/// - [k], the length of the k-grams in the [Map<String, Set<String>>]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a
///   [Map<String, Set<String>>] for a collection of k-grams.
abstract class DictoSaurusBase
    with DictionaryMixin, ThesaurusMixin, AutoCorrectMixin, DictoSaurusMixin {
  //
  /// A const generative constructor for sub classes.
  const DictoSaurusBase();
}

/// A mixin class that implements [DictoSaurus.expandTerm].
abstract class DictoSaurusMixin implements DictoSaurus {
  //

  @override
  Future<List<String>> expandTerm(String term, [int limit = 5]) async {
    final retVal = <String>{term};
    final entry = await getEntry(term, {TermProperty.synonyms});
    if (entry != null) {
      retVal.add(term);
      retVal.addAll(
          entry.allSynonyms().where((element) => !element.contains(' ')));
    }
    if (retVal.length < limit) {
      final suggestions = await suggestionsFor(term, limit);
      retVal.addAll(suggestions);
    }
    final list = retVal.toList();
    return (list.length > limit) ? list.sublist(0, limit) : list;
  }
}

/// A [DictoSaurus] implementation used by the unnamed [DictoSaurus] factory
/// constructor.
class _DictoSaurusImpl extends DictoSaurusBase {
  //

  /// Initializes a const [_DictoSaurusImpl].
  const _DictoSaurusImpl(this.kGramIndexLoader, this.dictionaryCallback, this.k,
      this.languageCode);

  /// Asynchronous callback that returns the properties of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  @override
  final int k;

  @override
  final Future<Map<String, Set<String>>> Function(Iterable<String> terms)
      kGramIndexLoader;

  @override
  final String languageCode;

  @override
  Future<TermProperties?> getEntry(String term,
          [Iterable<TermProperty>? fields]) =>
      dictionaryCallback(term, fields);
}

/// A [DictoSaurus] with final [autoCorrect] and [dictionary] fields and
/// a generative constructor.
class _DictoSaurusFromComponentsImpl extends DictoSaurusBase {
  //

  final AutoCorrectBase autoCorrect;

  final Dictionary dictionary;

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [dictionary] instances.
  const _DictoSaurusFromComponentsImpl(this.dictionary, this.autoCorrect);

  @override
  Future<TermProperties?> getEntry(String term,
          [Iterable<TermProperty>? fields]) =>
      dictionary.getEntry(term);

  @override
  int get k => autoCorrect.k;

  @override
  Future<Map<String, Set<String>>> Function(Iterable<String> kGrams)
      get kGramIndexLoader => autoCorrect.kGramIndexLoader;

  @override
  String get languageCode => dictionary.languageCode;
}
