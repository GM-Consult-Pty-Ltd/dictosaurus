// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// Dictionary, thesaurus and term expansion utilities.
///
/// Also exports the core classes from the `text_indexing` package.
library dictosaurus;

export 'src/auto_correct/auto_correct.dart' show AutoCorrect;
export 'src/thesaurus/thesaurus.dart' show Thesaurus;
export 'src/dictionary/_index.dart'
    show
        Dictionary,
        TermProperties,
        TermPropertiesMixin,
        TermDefinition,
        PartOfSpeech;
export 'src/dictosaurus.dart'
    show DictoSaurus, DictoSaurusBase, DictoSaurusMixin;
export 'package:text_indexing/text_indexing.dart';
