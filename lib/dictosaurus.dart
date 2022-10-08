// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// Dictionary, thesaurus and term expansion utilities.
library dictosaurus;

export 'src/auto_correct/auto_correct.dart' show AutoCorrect;
export 'src/thesaurus/thesaurus.dart' show Thesaurus, ThesaurusMixin;
export 'src/dictionary/_index.dart'
    show
        Dictionary,
        DictionaryMixin,
        TermProperties,
        TermPropertiesMixin,
        TermDefinition,
        PartOfSpeech;
export 'src/dictosaurus.dart'
    show DictoSaurus, DictoSaurusBase, DictoSaurusMixin;
