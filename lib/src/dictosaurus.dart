// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// The [DictoSaurus] composition class leverages a [Vocabulary],
/// [Thesaurus] and [AutoCorrect] which it uses to expose the following
/// methods:
/// - [definitionOf];,
/// - [synonymsOf];
/// - [suggestionsFor] ; and
/// - [expandTerm] .
abstract class DictoSaurus {
  //
  Future<String> definitionOf(String term);

  Future<Set<String>> synonymsOf(String term);

  Future<List<String>> suggestionsFor(String term);
}
