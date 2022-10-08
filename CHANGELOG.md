<!-- 
BSD 3-Clause License
Copyright (c) 2022, GM Consult Pty Ltd
All rights reserved. 
-->

## 0.0.2
**Beta Stable Release**

### *Breaking changes*
* Removed `text_indexing` package from library exports.
* Removed `AutoCorrect` unnamed factory constructor.
* Removed `AutoCorrect.inMemory` factory constructor.
* Changed signature of `DictoSaurus` unnamed factory.
* Removed [Dictionary], [Thesaurus] and [AutoCorrect] implementations from [DictoSaurusMixin].

### *New*
* Added [DictoSaurus.fromComponents] factory constructor.
* Added [DictionaryMixin], [ThesaurusMixin] and [AutoCorrectMixin] implementations to [DictoSaurusBase].
* Added `ThesaurusMixin` to `dictosaurus` package exports.
* Added `[AutoCorrect.kGram]` static factory method.

## 0.0.1+2
**Beta Stable Release**

### *New*
* Added `DictionaryMixin` to `dictosaurus` package exports.

### *Updated*
* Documentation.

## 0.0.1+1
**Beta Stable Release**

### *Updated*
* Documentation.

## 0.0.1
**Beta Stable Release**

### *Updated*
* Documentation.

## 0.0.1-beta.7

### *Breaking changes*
* Renamed `DictionaryEntry` to `TermProperties`.
* Renamed `TermVariant` to `TermDefinition`.
* Added `Dictionary.phrasesWith`, `Dictionary.definitionsFor` and `Dictionary.inflectionsOf` methods.
* Interface `Dictosaurus` implements `Dictionary`, `Thesaurus` and `Autocorrect`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.1-beta.6

### *Updated*
* Documentation.
* Dependencies.

## 0.0.1-beta.5
**PRE-RELEASE, BREAKING CHANGES**

### *Breaking changes*
* Removed `Dictionary.inMemory` factory.
* Removed `Thesaurus.inMemory` factory.
* Removed `Dictosaurus.inMemory` factory.
* Removed `DictionaryMap` typedef.
* Changed `Dictosaurus` interface.

### *Updated*
* Documentation.
* License.

## 0.0.1-beta.4
**PRE-RELEASE**

### *New*
* Functional early versions of `Dictionary`, `AutoCorrect`, `Thesaurus` and `DictoSaurus`.
* Object model `TermProperties`.
* Object model `TermDefinition`.
* Enum `PartOfSpeech`.


## 0.0.1-beta.3
**PRE-RELEASE**

### *Updated*
* Documentation.

## 0.0.1-beta.2
**PRE-RELEASE**

### *Updated*
* Documentation.

## 0.0.1-beta.1

**PRE-RELEASE**
* Initial version.