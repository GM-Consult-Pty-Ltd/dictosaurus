// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';
import 'dictionary_entry.dart';

///  Maps the words in a language (dictionaryMap) to their definitions (meanings).
///
/// Alias for `Map<String, String>`.
typedef DictionaryMap = Map<String, String>;

/// The [Dictionary] interface:
/// - exposes the [definitionsOf] method that returns a set of definitions of
///   a term and its tokenized versions; and
/// - the [tokenizer] is used to get tokenized versions of a term and should be
///   the same as that used to create the dictionary index queried by the
///   [Dictionary].
abstract class Dictionary {
//

  /// Returns a [DictionaryEntry] for [term] from the [Dictionary].
  Future<DictionaryEntry?> getEntry(String term);

  /// Returns a set of definitions of [term] and its tokenized versions.
  ///
  /// Returns an empty [DictionaryMap] if no meanings were found for the
  /// [term] or any of its tokenized versions.
  Future<DictionaryMap> definitionsOf(Term term);

  /// The [Tokenizer] used by the [AutoCorrect] to filter terms.
  Tokenizer get tokenizer;

  /// The [Dictionary.inMemory] factory constructor initializes a [Dictionary]
  /// with in-memory [DictionaryMap] instance [dictionaryMap].
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and should be
  /// the same as that used to create the dictionary index queried by the
  /// [Dictionary].
  factory Dictionary.inMemory(DictionaryMap dictionaryMap,
          {Tokenizer? tokenizer}) =>
      _InMemoryDictionary(dictionaryMap, tokenizer ?? TextTokenizer().tokenize);

  /// The unnamed [Dictionary] factory constructor initializes a [Dictionary]
  /// with an asynchronous callback [dictionaryCallback] to return the meaning
  /// of a term.
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and should be
  /// the same as that used to create the dictionary index queried by the
  /// [Dictionary].
  factory Dictionary(
          Future<DictionaryMap> Function(Iterable<String> terms)
              dictionaryCallback,
          {Tokenizer? tokenizer}) =>
      _DictionaryImpl(
          dictionaryCallback, tokenizer ?? TextTokenizer().tokenize);
}

/// Mixin class that implements the [Dictionary] interface:
/// - [definitionsOf] method uses the [tokenizer] to tokenize a term, then
///   asynchronously gets the meanings of the tokenized version of term using
///   the [dictionaryCallback];
/// - the [tokenizer] is used to get tokenized versions of a term and should be
///   the same as that used to create the dictionary index queried by the
///   [Dictionary]; and
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a collection of terms from a dictionary index.
abstract class DictionaryMixin implements Dictionary {
  //

  @override
  Future<DictionaryMap> definitionsOf(Term term) async {
    final terms = [term];
    final tokens = (await tokenizer(term));
    terms.addAll(tokens.map((e) => e.term));
    return await dictionaryCallback(terms);
  }

  /// A asynchronous callback that returns the meanings of a collection of
  /// terms.
  Future<DictionaryMap> Function(Iterable<String> terms) get dictionaryCallback;
}

/// An abstract base class that implements the [Dictionary] interface:
/// - [definitionsOf] method uses the [tokenizer] to tokenize a term, then
///   asynchronously gets the meanings of the tokenized version of term using
///   the [dictionaryCallback];
/// - the [tokenizer] is used to get tokenized versions of a term and
///   should be the same as that used to create the dictionary index queried by
///   the [Dictionary]; and
/// - [dictionaryCallback] is an asynchronous callback that returns the
///   meaning of a collection of terms from a dictionary index.
///
/// Provides a default const unnamed generative constructor for sub classes.
abstract class DictionaryBase with DictionaryMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const DictionaryBase();

  //
}

/// The [_InMemoryDictionary] extends [DictionaryBase] and initializes a
/// [Dictionary] with in-memory [DictionaryMap] instance [dictionaryMap].
class _InMemoryDictionary extends DictionaryBase {
  //

  /// Returns the values from [dictionaryMap] for the terms (keys).
  @override
  Future<DictionaryMap> Function(Iterable<String> terms)
      get dictionaryCallback => (terms) async {
            final retVal = <String, String>{};
            for (final term in terms) {
              final meaning = dictionaryMap[term];
              if (meaning != null) {
                retVal[term] = meaning;
              }
            }
            return retVal;
          };

  @override
  final Tokenizer tokenizer;

  /// An in-memory [DictionaryMap].
  final DictionaryMap dictionaryMap;

  /// Initializes a const [_InMemoryDictionary] with the in-memory
  /// [DictionaryMap] parameter [dictionaryMap].
  const _InMemoryDictionary(this.dictionaryMap, this.tokenizer);
}

/// Implementation of [DictionaryBase]
class _DictionaryImpl extends DictionaryBase {
//

  @override
  final Tokenizer tokenizer;

  @override
  final Future<DictionaryMap> Function(Iterable<String> terms)
      dictionaryCallback;

  /// Initializes a const [_DictionaryImpl] with an asynchronous callback
  /// [dictionaryCallback] that  returns a set of synonyms for a term..\
  const _DictionaryImpl(this.dictionaryCallback, this.tokenizer);
}
