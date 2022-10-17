// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// The names of fields that enumerate the properties of a term.
enum DictionaryEndpoint {
  //

  /// The stemmed version of the term.
  stem,

  /// The lemma of the term.
  lemmas,

  /// Definitions of the term.
  definitions,

  /// Inflections of the term.
  inflections,

  /// A set of phrases containing the term.
  phrases,

  /// Synonyms of the term.
  synonyms,

  /// Antonyms of the term.
  antonyms,

  /// Search for a term.
  search,

  /// Translations of the term.
  translations
}
