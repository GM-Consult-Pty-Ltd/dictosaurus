<!-- 
BSD 3-Clause License
Copyright (c) 2022, GM Consult Pty Ltd
All rights reserved. 
-->

[![GM Consult Pty Ltd](https://raw.githubusercontent.com/GM-Consult-Pty-Ltd/dictosaurus/main/assets/images/dictosaurus.png?raw=true "GM Consult Pty Ltd")](https://github.com/GM-Consult-Pty-Ltd)
## **Extensions on String that provide dictionary and thesaurus functions.**

*THIS PACKAGE IS **PRE-RELEASE**, IN ACTIVE DEVELOPMENT AND SUBJECT TO DAILY BREAKING CHANGES.*

Skip to section:
- [Overview](#overview)
- [Usage](#usage)
- [API](#api)
- [Definitions](#definitions)
- [References](#references)
- [Issues](#issues)

## Overview

The `dictosaurus` package provides language reference utilities used in information retrieval systems. It relies on three key indexes:
* a `vocabulary` (see [definitions](#definitions)) that maps the words in a language (vocabulary) to their definitions (meanings);
* a `synonyms index` that maps the `vocabulary` to a collection of synonyms, which may be empty; and
* a `k-gram index` that maps k-grams to the `vocabulary`.

![DictoSaurus Artifacts](https://github.com/GM-Consult-Pty-Ltd/dictosaurus/raw/main/assets/images/dictosaurus_artifacts.png?raw=true?raw=true "DictoSaurus Artifacts")

Three utility classes provide dictionary and thesaurus functions:
* the [Vocabulary]() class exposes the [Future<String> definitionOf(String term)]() function, looking up the meaning of the `term` in a `vocabulary`;
* the [Thesaurus]() class exposes the [Future<Set<String>> synonymsOf(String term)]() function, looking up the synonyms of the `term` in a `synonyms index`; and
* the [AutoCorrect]() class exposes the [Future<List<String>> suggestionsFor(String term)]() function that returns a set of unique alternative spellings for `term` by converting the `term` to `k-grams` and then finding the best matches for the (misspelt) `term` from the `k-gram index`, ordered in descending order of relevance (i.e. best match first).

The [DictoSaurus]() composition class leverages a [Vocabulary](), [Thesaurus]() and [AutoCorrect]() which it uses to expose the [Future<String> definitionOf(String term)](),  [Future<Set<String>> synonymsOf(String term)]() and [Future<List<String>> suggestionsFor(String term)]() functions. 

The [DictoSaurus]() also exposes the [Future<List<String>> expandTerm(String term)]() function that looks up the `term` in the [Vocabulary](), [Thesaurus]() and [AutoCorrect]() classes to return a term-expansion in descending order of relevance (best match first). If the `term` is found in the [Vocabulary]() it will appear as the first element of the returned list. If it is not found in the [Vocabulary]() it will not be in the returned list as it is likely to be misspelt.

The [DictoSaurus.english]() static const instance uses the included `vocabulary`, `synonymsIndex` and `kGramIndex` hashmaps. For other languages or a custom implementation, initialize the [DictoSaurus]() using the [DictoSaurus.async]() factory constructor whichuses asynchronous callbacks to `vocabulary`, `synonymsIndex` and `kGramIndex` APIs. The [DictoSaurus.async]() factory constructor has a named, required parameter [TextAnalyzerConfiguration configuration](). The optional named parameter ` int k` (the k-gram length) defaults to 3 (tri-gram).

If the [DictoSaurus]() is used as a `term expander` in an information retrieval system, the [DictoSaurus.configuration]() must use the same tokenizing algorithm as the index.

Refer to the [references](#references) to learn more about information retrieval systems.

## Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  dictosaurus: <latest_version>
```

In your code file add the following import:

```dart
import 'package:dictosaurus/dictosaurus.dart';
```

TODO: describe usage.

## API

The [API](https://pub.dev/documentation/dictosaurus/latest/) exposes

TODO: describe the API

## Definitions

The following definitions are used throughout the [documentation](https://pub.dev/documentation/text_analysis/latest/):

* `corpus`- the collection of `documents` for which an `index` is maintained.
* `character filter` - filters characters from text in preparation of tokenization.  
* `dictionary` - is a hash of `terms` (`vocabulary`) to the frequency of occurence in the `corpus` documents.
* `document` - a record in the `corpus`, that has a unique identifier (`docId`) in the `corpus`'s primary key and that contains one or more text zones/fields  that are indexed.
* `index` - an [inverted index](https://en.wikipedia.org/wiki/Inverted_index) used to look up `document` references from the `corpus` against a `vocabulary` of `terms`. 
`k-gram` - a sequence of (any) k consecutive characters from a `term`. A k-gram can start with "$", dentoting the start of the `term`, and end with "$", denoting the end of the `term`. The 3-grams for "castle" are { $ca, cas, ast, stl, tle, le$ }.
* `lemmatizer` - lemmatisation (or lemmatization) in linguistics is the process of grouping together the inflected forms of a word so they can be analysed as a single item, identified by the word's lemma, or dictionary form (from [Wikipedia (2)](https://en.wikipedia.org/wiki/Lemmatisation)).
* `postings` - a separate index that records which `documents` the `vocabulary` occurs in. In this implementation we also record the positions of each `term` in the `text` to create a positional inverted `index`.
* `postings list` - a record of the positions of a `term` in a `document`. A position of a `term` refers to the index of the `term` in an array that contains all the `terms` in the `text`.
* `synonym` - a word, morpheme, or phrase that means exactly or nearly the same as another word, morpheme, or phrase in a given language (from [Wikipedia (4)](https://en.wikipedia.org/wiki/Synonym)).
* `stemmer` -  stemming is the process of reducing inflected (or sometimes derived) words to their word stem, base or root form—generally a written word form (from [Wikipedia (3)](https://en.wikipedia.org/wiki/Stemming)).
* `stopwords` - common words in a language that are excluded from indexing.
* `term` - a word or phrase that is indexed from the `corpus`. The `term` may differ from the actual word used in the corpus depending on the `tokenizer` used.
* `term filter` - filters unwanted terms from a collection of terms (e.g. stopwords), breaks compound terms into separate terms and / or manipulates terms by invoking a `stemmer` and / or `lemmatizer`.
* `term frequency (Ft)` is the frequency of a `term` in an index or indexed object.
* `term position` is the zero-based index of a `term` in an ordered array of `terms` tokenized from the `corpus`.
* `text` - the indexable content of a `document`.
* `token` - representation of a `term` in a text source returned by a `tokenizer`. The token may include information about the `term` position in the source text.
* `token filter` - returns a subset of `tokens` from the tokenizer output.
* `tokenizer` - a function that returns a collection of `token`s from the terms in a text source after applying a `character filter` and `term filter`.
* `vocabulary` - the collection of `terms` indexed from the `corpus` or the words in a language.

## References

* [Manning, Raghavan and Schütze, "*Introduction to Information Retrieval*", Cambridge University Press, 2008](https://nlp.stanford.edu/IR-book/pdf/irbookprint.pdf)
* [University of Cambridge, 2016 "*Information Retrieval*", course notes, Dr Ronan Cummins, 2016](https://www.cl.cam.ac.uk/teaching/1516/InfoRtrv/)
* [Wikipedia (1), "*Inverted Index*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Inverted_index)
* [Wikipedia (2), "*Lemmatisation*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Lemmatisation)
* [Wikipedia (3), "*Stemming*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Stemming)
* [Wikipedia (4), "*Synonym*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Synonym)

## Issues

If you find a bug please fill an [issue](https://github.com/GM-Consult-Pty-Ltd/dictosaurus/issues).  

This project is a supporting package for a revenue project that has priority call on resources, so please be patient if we don't respond immediately to issues or pull requests.


