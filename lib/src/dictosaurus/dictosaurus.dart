// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// The [DictoSaurus] interface implements the [Dictionary] and [AutoCorrect]
/// interfaces.
///
/// The [DictoSaurus] interface also exposes the [DictoSaurus.expandTerm]
/// method that performs `term-expansion`, returning a list of terms in
/// descending order of relevance (best match first). The (expanded) list of
/// terms includes the `term`, its `synonyms` (if any) and spelling correction
/// suggestions.
abstract class DictoSaurus implements Dictionary, AutoCorrect {
  //

  /// Initializes a [DictoSaurus] with [autoCorrect] and [dictionary] instances.
  factory DictoSaurus.fromComponents(
          {required Dictionary dictionary,
          required AutoCorrectBase autoCorrect}) =>
      _DictoSaurusFromComponentsImpl(dictionary, autoCorrect);

  /// Initializes a [DictoSaurus] with [language], [k]-gram length and
  /// [kGramIndexLoader].
  factory DictoSaurus(
          {required DictionaryCallback dictionaryCallback,
          required TranslationCallback translationCallback,
          required Future<Map<String, Set<String>>> Function(
                  Iterable<String> terms)
              kGramIndexLoader,
          Language language = Language.en_US,
          int k = 2}) =>
      _DictoSaurusImpl(kGramIndexLoader, dictionaryCallback,
          translationCallback, k, language);

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

/// Implements [DictoSaurus] by mixing in [DictoSaurusMixin] and
/// [AutoCorrectMixin].
///
/// Sub-classes must override:
/// - [language], the [Language] of terms in the dictionary;
/// - [getEntry], a function that returns a [DictionaryEntry] for a term;
/// - [translate], a function that returns translations for a term as
///   [DictionaryEntry];
/// - [k], the length of the k-grams in the [Map<String, Set<String>>]; and
/// - [kGramIndexLoader], an asynchronous callback function that returns a
///   [Map<String, Set<String>>] for a collection of k-grams.
abstract class DictoSaurusBase with AutoCorrectMixin, DictoSaurusMixin {
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
    retVal.add(term);
    final synonyms = (await getEntry(term))
        ?.allSynonyms()
        .where((element) => !element.contains(' '));
    if (synonyms != null) {
      retVal.addAll(synonyms);
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
  const _DictoSaurusImpl(this.kGramIndexLoader, this.dictionaryCallback,
      this.translationCallback, this.k, this.language);

  /// Asynchronous callback that returns the properties of a term from a
  /// dictionary provider.
  final DictionaryCallback dictionaryCallback;

  /// An asynchronous callback that returns the meaning of a term from a
  /// dictionary provider.
  final TranslationCallback translationCallback;

  @override
  final int k;

  @override
  final Future<Map<String, Set<String>>> Function(Iterable<String> terms)
      kGramIndexLoader;

  @override
  final Language language;

  @override
  Future<DictionaryEntry?> getEntry(String term) => dictionaryCallback(term);

  @override
  Future<DictionaryEntry?> translate(String term, Language sourceLanguage) =>
      translationCallback(term, sourceLanguage);
}

/// A [DictoSaurus] with final [autoCorrect] and [dictionary] endpoint and
/// a generative constructor.
class _DictoSaurusFromComponentsImpl extends DictoSaurusBase {
  //

  final AutoCorrectBase autoCorrect;

  final Dictionary dictionary;

  /// Initializes a [DictoSaurus] with [autoCorrect], [thesaurus] and
  /// [dictionary] instances.
  const _DictoSaurusFromComponentsImpl(this.dictionary, this.autoCorrect);

  @override
  Future<DictionaryEntry?> getEntry(String term) => dictionary.getEntry(term);

  @override
  int get k => autoCorrect.k;

  @override
  Future<Map<String, Set<String>>> Function(Iterable<String> kGrams)
      get kGramIndexLoader => autoCorrect.kGramIndexLoader;

  @override
  Language get language => dictionary.language;

  @override
  Future<DictionaryEntry?> translate(String term, Language sourceLanguage) =>
      dictionary.translate(term, sourceLanguage);
}
