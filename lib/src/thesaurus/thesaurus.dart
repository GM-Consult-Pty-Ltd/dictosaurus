// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// The [Thesaurus] interface:
/// - exposes the [synonymsOf] method returns a set of synonyms for a term and
///   its tokenized versions from a synonyms index; and
/// - the [tokenizer] is used to get tokenized versions of a term and
///   should be the same as that used to create the synonyms index queried by
///   the [Thesaurus].
abstract class Thesaurus {
  //

  /// The [tokenizer] is used to get tokenized versions of a term.
  ///
  /// The [tokenizer] should be the same as that used to create the synonyms
  /// index queried by the [Thesaurus].
  Tokenizer get tokenizer;

  /// The [Thesaurus.inMemory] factory constructor initializes a [Thesaurus]
  /// with in-memory [SynonymsMap] instance [synonymsMap].
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and
  /// should be the same as that used to create the synonyms index queried by
  /// the [Thesaurus]. The default [tokenizer] is [English].
  factory Thesaurus.inMemory(SynonymsMap synonymsMap, {Tokenizer? tokenizer}) =>
      _ThesaurusImpl(synonymsMap, tokenizer ?? TextTokenizer().tokenize);

  /// The unnamed [Thesaurus] factory constructor initializes a [Thesaurus]
  /// with an asynchronous callback [synonymsCallback] to return the synonyms
  /// for a term and its tokenized versions.
  ///
  /// The [tokenizer] is used to get tokenized versions of a term and
  /// should be the same as that used to create the synonyms index queried by
  /// the [Thesaurus]. The default [tokenizer] is [English].
  factory Thesaurus(
          Future<SynonymsMap> Function(Iterable<String> terms) synonymsCallback,
          {Tokenizer? tokenizer}) =>
      _AsyncCallbackThesaurus(
          synonymsCallback, tokenizer ?? TextTokenizer().tokenize);

  /// Returns a set of synonyms for [term] and its tokenized versions.
  ///
  /// Returns an empty [SynonymsMap] if no synonyms were found for the
  /// [term] or any of its tokenized versions.
  Future<SynonymsMap> synonymsOf(String term);

//
}

/// Mixin class that implements the [Thesaurus] interface:
/// - the [tokenizer] is used to get tokenized versions of a term and
///   should be the same as that used to create the synonyms index queried by
///   the [Thesaurus];
/// - the [synonymsOf] method uses the [tokenizer] to tokenize a term, then
///   asynchronously gets the synonyms for the tokenized version of term using
///   the [synonymsCallback]; and
/// - [synonymsCallback] is an asynchronous callback that returns the
///   synonyms of a collection of terms from a synonyms index.
abstract class ThesaurusMixin implements Thesaurus {
  //

  /// A asynchronous callback that returns a set of synonyms for collection of
  /// terms.
  Future<SynonymsMap> Function(Iterable<String> terms) get synonymsCallback;

  @override
  Future<SynonymsMap> synonymsOf(String term) async {
    final terms = [term];
    final tokens = (await tokenizer(term));
    terms.addAll(tokens.map((e) => e.term));
    return await synonymsCallback(terms);
  }

  //
}

/// An abstract base class that that implements the [Thesaurus] interface:
/// - the [tokenizer] is used to get tokenized versions of a term and
///   should be the same as that used to create the synonyms index queried by
///   the [Thesaurus];
/// - the [synonymsOf] method uses the [tokenizer] to tokenize a term, then
///   asynchronously gets the synonyms for the tokenized version of term using
///   the [synonymsCallback]; and
/// - [synonymsCallback] is an asynchronous callback that returns the
///   synonyms of a collection of terms from a synonyms index.
///
/// Provides a default const unnamed generative constructor for sub classes.
abstract class ThesaurusBase with ThesaurusMixin {
  //

  /// A default const unnamed generative constructor for sub classes.
  const ThesaurusBase();
}

/// Implementation of [Thesaurus] that uses a in-memory [SynonymsMap].
class _ThesaurusImpl extends ThesaurusBase {
//

  @override
  final Tokenizer tokenizer;

  /// An in-memory [SynonymsMap].
  final SynonymsMap synonymsMap;

  /// Returns the values from [synonymsMap] for the terms (keys).
  @override
  Future<SynonymsMap> Function(Iterable<String> terms) get synonymsCallback =>
      (terms) async {
        final SynonymsMap retVal = {};
        for (final term in terms) {
          final meaning = synonymsMap[term];
          if (meaning != null) {
            retVal[term] = meaning;
          }
        }
        return retVal;
      };

  /// Initializes a const [_ThesaurusImpl] with an in-memory
  /// [synonymsMap] hashmap.
  const _ThesaurusImpl(this.synonymsMap, this.tokenizer);
}

/// Implementation of [Thesaurus] that uses an asynchronous callback
/// [synonymsCallback] to  return a set of synonyms for a term.
class _AsyncCallbackThesaurus extends ThesaurusBase {
//

  @override
  final Tokenizer tokenizer;

  @override
  final Future<SynonymsMap> Function(Iterable<String> terms) synonymsCallback;

  /// Initializes a const [_AsyncCallbackThesaurus] with an asynchronous
  /// [synonymsCallback].
  const _AsyncCallbackThesaurus(this.synonymsCallback, this.tokenizer);
}
