// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// The `dictosaurus` library provides 'natural language processing (NLP)'
/// utilities used in `information retrieval systems`.
///
/// Three utility classes provide dictionary and thesaurus and term expansion
/// functions:
/// - the [Dictionary] interface exposes methods that return the properties
///   (definitions, inflections, part-of-speech, phrases, synonyms and
///   antonyms) of a `term`;
/// - the [Thesaurus] interface exposes methods that return the synonyms or
///   antonyms of a `term` ; and
/// - the [AutoCorrect] interface exposes methods that return alternative
///   spellings for a `term` or terms that start with the same characters.
///
/// The [DictoSaurus] interface implements the [Dictionary], [Thesaurus] and
/// [AutoCorrect] interfaces.
///
/// The [DictoSaurus] interface also exposes the [DictoSaurus.expandTerm]
/// method that performs `term-expansion`, returning a list of terms in
/// descending order of relevance (best match first). The (expanded) list of
/// terms includes the `term`, its `synonyms` (if any) and spelling correction
/// suggestions.
///
/// We use an *interface > implementation mixin > base-class > implementation
/// class pattern*:
/// - the `interface` is an abstract class that exposes fields and methods
///  but contains no implementation code. The `interface` may expose a factory
///  constructor that returns an `implementation class` instance;
/// - the `implementation mixin` implements the `interface` class methods, but
///  not the input fields; and
/// - the `base-class` is an abstract class with the `implementation mixin` and
///  exposes a default, unnamed generative const constructor for sub-classes.
///  The intention is that `implementation classes` extend the `base class`,
///  overriding the `interface` input fields with final properties passed in
///  via a const generative constructor.
///
/// The class naming convention for this pattern is *"Interface" >
/// "InterfaceMixin" > "InterfaceBase"*.
library dictosaurus;

export 'src/auto_correct/auto_correct.dart'
    show AutoCorrect, AutoCorrectMixin, AutoCorrectBase;
export 'src/thesaurus/thesaurus.dart'
    show Thesaurus, ThesaurusMixin, ThesaurusBase;
export 'src/dictionary/_index.dart'
    show
        Dictionary,
        DictionaryMixin,
        DictionaryBase,
        TermProperties,
        TermPropertiesMixin,
        TermPropertiesBase,
        TermDefinition,
        TermDefinitionMixin,
        TermDefinitionBase,
        PartOfSpeech;
export 'src/dictosaurus.dart'
    show DictoSaurus, DictoSaurusMixin, DictoSaurusBase;
