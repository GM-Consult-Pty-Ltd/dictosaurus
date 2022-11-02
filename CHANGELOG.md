<!-- 
BSD 3-Clause License
Copyright (c) 2022, GM Consult Pty Ltd
All rights reserved. 
-->

## 0.0.23
**Beta**

### *Updated*
* Dependencies.
* Bumped `text_analysis` to version `0.23.5`.
* Bumped `text_indexing` to version `0.22.2`.

## 0.0.22+1
**Beta**

### *Updated*
* Bumped `text_analysis` to version `0.23.4`.
* Bumped `text_indexing` to version `0.22.1`.

## 0.0.22
**Beta**

### *Updated*
* Bumped `text_analysis` to version `0.23.1`.
* Bumped `text_indexing` to version `0.21.0`.

## 0.0.21
**Beta**

### *Updated*
* Bumped `text_analysis` to version `0.20.0`.
* Bumped `text_indexing` to version `0.19.0`.


## 0.0.20+2
**Beta**

### *Updated*
* Documentation.

## 0.0.20+1
**Beta**

### *Updated*
* Documentation.

## 0.0.20
**Beta**

### *Updated*
* Bumped `text_analysis` to version `0.18.0`.

## 0.0.19
**Beta**

### *Updated*
* Bumped `text_analysis` to version `0.17.1`.

### 0.0.18+1
**Beta**

### *New*
* Added `extensions` mini library.

## 0.0.18
**Beta**

### *Bug fixes*
* Fixed error where `limit` and `k` parameters were not applied by `AutoCorrectMixin.suggestionsFor`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.17
**Beta**

### *Breaking changes*
* Added field `TermVariant.language`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.16
**Beta**

### *Breaking changes*
* Changed signature of function definition `TranslationCallback`.
* Changed signature and return value type of `Dictionary.translate`.
* Deleted field `Pronunciation.languageCodes`, replaced with `Pronunciation.dialect`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.15
**Beta**

### *Breaking changes*
* Removed `Thesaurus` interface.
* Renamed `TermProperties` interface to `DictionaryEntry`.
* Removed parameter `endpoint` from `DictionaryCallback` function definition.
* Removed `DictionaryEndpoint` enum.
* Removed `Dictionary.phrasesWith`, `Dictionary.inflectionsOf`, `Dictionary.definitionsFor`, `Dictionary.synonymsOf`, `Dictionary.pronunciationsOf`, `Dictionary.lemmasOf` and `Dictionary.antonymsOf` methods.
* Added method `Dictionary.getEntry` from interface.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.14
**Beta**

### *Breaking changes*
* Removed method `Dictionary.getEntry` from interface.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.13
**Beta**

### *New*
* Added `DictionaryEndpoint.search` enumeration.
* Added `TermProperties.addVariants` method.
* Changed added defaults to `TermVariant` unnamed factory parameters.

### *Updated*
* Documentation.

## 0.0.12
**Beta**

### *New*
* Added `DictionaryEndpoint.etymologies` enumeration.

### *Updated*
* Documentation.

## 0.0.11
**Beta**

### *Breaking changes*
* Changed signature of `Dictionary.getEntry` method.
* Renamed `TermProperty` enum to `DictionaryEndpoint`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.10+1
**Beta**

### *New*
*Added `LanguageStringExtensions` to exports.

### *Updated*
* Documentation.

## 0.0.10
**Beta**

### *Breaking changes*
* Changed `String TermProperties.languageCode` to `Language TermProperties.language`.
* Changed `String Dictionary.languageCode` to `Language Dictionary.language`.
* Changed `String Dictosaurus.languageCode` to `Language Dictosaurus.language`.
* Added `Dictionary.translate` method to `Dictionary`.

### *New*
* Added `Language` to package exports.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.9
**Beta**

### *Breaking changes*
* Added property `TermVariant.etymologies`.
* Added method `TermProperties.etymologiesOf`.
* Added method `TermProperties.allEtymologies`.
* Added method `TermProperties.etymologiesMap`.
* Added method `Dictionary.pronunciationsOf`.
* Added method `Dictionary.etymologiesOf`.

### *New*
* Added property `TermVariant.etymologies`.
* Added method `TermProperties.etymologiesOf`.
* Added method `TermProperties.allEtymologies`.
* Added method `TermProperties.etymologiesMap`.
* Added method `Dictionary.pronunciationsOf`.
* Added method `Dictionary.etymologiesOf`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.8
**Beta**

### *Breaking changes*
* Removed property `TermProperties.phonetic`.
* Renamed class `TermVariant` to `TermVariant`.
* Added property `TermVariant.pronunciations`.
* Added method `TermProperties.pronunciationsOf`.
* Added method `TermProperties.allPronunciations`.
* Added method `TermProperties.pronunciationsMap`.

### *New*
* Added class [Pronunciation].
* Added property `TermVariant.pronunciations`.
* Added method `TermProperties.pronunciationsOf`.
* Added method `TermProperties.allPronunciations`.
* Added method `TermProperties.pronunciationsMap`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.7+1
**Beta**

### *Updated*
* Dependencies.

## 0.0.7
**Beta**

### *Breaking changes*
* New method `TermProperties.lemmasOf`.
* New method `TermProperties.allLemmas`.
* New method `TermProperties.lemmasMap`.
* New method `Thesaurus.lemmasOf`.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.6
**Beta**

### *Breaking changes*
* Removed field [TermProperties.lemma].
* Changed Signature of [TermVariant] unnamed factory.
* Changed Signature of [TermProperties] unnamed factory.

### *New*
* Added [TermVariant.lemmas] field.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.5
**Beta**

### *Breaking changes*
* Changed signature of `Dictionary.getEntry` method.
* Changed signature of `Thesaurus.getEntry` method.
* Changed signature of `DictionaryCallback` function definition.

### *New*
* Added [DictionaryEndpoint ] enumeration.

### *Updated*
* Documentation.

## 0.0.4+5
**Beta**

### *Updated*
* Documentation.

## 0.0.4+4
**Beta**

### *Updated*
* Documentation.

## 0.0.4+3
**Beta**

### *Updated*
* Documentation.

## 0.0.4+2
**Beta**

### *Updated*
* Documentation.

## 0.0.4+1
**Beta**

### *Updated*
* Documentation.

## 0.0.4
**Beta**

### *Breaking changes*
* Changed field `TermProperties.synonymsMap` to a method.
* Changed field `TermProperties.antonymsMap` to a method.
* Changed field `TermProperties.definitionsMap` to a method.
* Changed field `TermProperties.phrasesMap` to a method.
* Changed field `TermProperties.inflectionsMap` to a method.

### *New*
* Added `TermProperties.phrasesWith` method.
* Added `TermProperties.inflectionsOf` method.
* Added `TermProperties.definitionsFor` method.
* Added `TermProperties.synonymsOf` method.
* Added `TermProperties.antonymsOf` method.

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.3
**Beta**

### *Breaking changes*
* Changed signature of `Thesaurus` unnamed factory, use `Thesaurus.callBack` factory instead.

### *New*
* Added `Thesaurus.callBack` factory constructor.
* Added `ThesaurusBase` abstract class.
* Added `DictionaryBase` abstract class.
* Added `AutoCorrectBase` abstract class.
* Added `TermPropertiesBase` abstract class.
* Added `TermVariantMixin` mixin class.

### *Updated*
* Documentation.

## 0.0.2+1
**Beta**

### *Updated*
* Documentation.

## 0.0.2
**Beta**

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

### *Updated*
* Documentation.
* Tests.
* Examples.
* Dependencies.

## 0.0.1+2
**Beta**

### *New*
* Added `DictionaryMixin` to `dictosaurus` package exports.

### *Updated*
* Documentation.

## 0.0.1+1
**Beta**

### *Updated*
* Documentation.

## 0.0.1
**Beta**

### *Updated*
* Documentation.

## 0.0.1-beta.7

### *Breaking changes*
* Renamed `DictionaryEntry` to `TermProperties`.
* Renamed `TermVariant` to `TermVariant`.
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
* Object model `TermVariant`.
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