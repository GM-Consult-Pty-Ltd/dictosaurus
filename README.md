<!-- 
BSD 3-Clause License
Copyright (c) 2022, GM Consult Pty Ltd
All rights reserved. 
-->

[![GM Consult Pty Ltd](https://raw.githubusercontent.com/GM-Consult-Pty-Ltd/dictosaurus/main/assets/images/dictosaurus.png?raw=true "GM Consult Pty Ltd")](https://github.com/GM-Consult-Pty-Ltd)
## **Dictionary, thesaurus and term expansion utilities.**

*THIS PACKAGE IS **PRE-RELEASE**, IN ACTIVE DEVELOPMENT AND SUBJECT TO DAILY BREAKING CHANGES.*

Skip to section:
- [Overview](#overview)
- [Usage](#usage)
- [API](#api)
- [Definitions](#definitions)
- [References](#references)
- [Issues](#issues)

## Overview

The `dictosaurus` package provides language reference utilities used in `information retrieval systems`. 

Three utility classes provide dictionary and thesaurus functions:
* the [Dictionary](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/Dictionary-class.html) class exposes methods that return the properties (definitions, inflections, part-of-speech, phrases, synonyms and antonyms) of a `term`;
* the [Thesaurus](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/Thesaurus-class.html) class exposes methods that return the synonyms or antonyms of a `term` ; and
* the [AutoCorrect](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/AutoCorrect-class.html) class exposes methods that return alternative spellings for a `term` or terms that start with the same characters.

The [DictoSaurus](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/DictoSaurus-class.html) class implements the [Dictionary](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/Dictionary-class.html), [Thesaurus](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/Thesaurus-class.html) and [AutoCorrect](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/AutoCorrect-class.html) interfaces. 

The [DictoSaurus](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/DictoSaurus-class.html) also exposes the [expandTerm](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/DictoSaurus/expandTerm.html) method that performs `term-expansion`, returning a list of terms in descending order of relevance (best match first). The (expanded) list of terms includes the `term`, its `synonyms` (if any) and spelling correction suggestions.

Refer to the [references](#references) to learn more about information retrieval systems.

## Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  dictosaurus: <latest_version>
```

In your code file add the following import:

```dart
// import the core interfaces, classes and mixins
import 'package:dictosaurus/dictosaurus.dart';

// import the typedefs if needed
import 'package:dictosaurus/type_definitions.dart';

```

Use of the [Dictosaurus](https://pub.dev/documentation/dictosaurus/latest/dictosaurus/DictoSaurus-class.html) is demonstrated below.

```dart
  // define a term with incorrect spelling.
  final misspeltterm = 'appel';

  // define a correctly spelled term.
  final term = 'swim';

  // get a Dictosaurus instance from an implementation class (not shown here)
  final dictoSaurus = await getDictoSaurus();

  // get spelling correction suggestions
  final corrections = await dictoSaurus.suggestionsFor(misspeltterm, 5);

  // expand the term
  final expansions = await dictoSaurus.expandTerm(term, 5);

  // get the defintions
  final definitions = await dictoSaurus.synonymsOf(term);

  // get the synonyms
  final synonyms = await dictoSaurus.synonymsOf(term);

  // get the antonyms
  final antonyms = await dictoSaurus.antonymsOf(term);

  // get the inflections
  final inflections = await dictoSaurus.inflectionsOf(term);

  // get the phrases
  final phrases = await dictoSaurus.phrasesWith(term);

  //prints:
  // [DictoSaurus] METHODS EXAMPLE                                             
  // ╔═══════════════════════════╤════════════════════════════════════════════╗
  // ║  Method                   │                 TestResult                 ║
  // ╟───────────────────────────┼────────────────────────────────────────────╢
  // ║  suggestionsFor("appel")  │  [apple, appear, april, aapl, sp...        ║
  // ║  expandTerm("swim")       │  [swim, bathe, dip, whirl, spin]           ║
  // ║  definitionsFor("swim")   │  {bathe, go swimming, take a dip, dip,...  ║
  // ║  synonymsOf("swim")       │  {bathe, go swimming, take a dip, dip,...  ║
  // ║  antonymsOf("swim")       │  {drown, sink}                             ║
  // ║  inflectionsOf("swim")    │  {swims, swimming, swam, swum}             ║
  // ║  phrasesWith("swim")      │  {they swam ashore, Adrian taught her ...  ║
  // ╚═══════════════════════════╧════════════════════════════════════════════╝

```

## API

Please refer to the [API documentation](https://pub.dev/documentation/dictosaurus/latest/).

We use an `interface > implementation mixin > base-class > implementation class pattern`:
* the `interface` is an abstract class that exposes fields and methods but contains no implementation code. The `interface` may expose a factory constructor that returns an `implementation class` instance;
* the `implementation mixin` implements the `interface` class methods, but not the input fields;
* the `base-class` is an abstract class with the `implementation mixin` and exposes a default, unnamed generative const constructor for sub-classes. The intention is that `implementation classes` extend the `base class`, overriding the `interface` input fields with final properties passed in via a const generative constructor; and
* the class naming convention for this pattern is `"Interface" > "InterfaceMixin" > "InterfaceBase"`.

## Definitions

The following definitions are used throughout the [documentation](https://pub.dev/documentation/text_analysis/latest/):

* `corpus`- the collection of `documents` for which an `index` is maintained.
* `character filter` - filters characters from text in preparation of tokenization.  
* `Damerau–Levenshtein distance` - a metric for measuring the `edit distance` between two `terms` by counting the minimum number of operations (insertions, deletions or substitutions of a single character, or transposition of two adjacent characters) required to change one `term` into the other.
* `dictionary` - a hash of `terms` (`vocabulary`) to the frequency of occurence in the `corpus` documents.
* `document` - a record in the `corpus`, that has a unique identifier (`docId`) in the `corpus`'s primary key and that contains one or more text fields that are indexed.
* `document frequency (dFt)` - the number of documents in the `corpus` that contain a term.
* `edit distance` - a measure of how dissimilar two terms are by counting the minimum number of operations required to transform one string into the other ([Wikipedia (7)](https://en.wikipedia.org/wiki/Edit_distance)).
- `Flesch reading ease score` - a readibility measure calculated from  sentence length and word length on a 100-point scale. The higher the score, the easier it is to understand the document ([Wikipedia(6)](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)).
- `Flesch-Kincaid grade level` - a readibility measure relative to U.S. school grade level.  It is also calculated from sentence length and word length ([Wikipedia(6)](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)).
* `index` - an [inverted index](https://en.wikipedia.org/wiki/Inverted_index) used to look up `document` references from the `corpus` against a `vocabulary` of `terms`. 
* `index-elimination` - selecting a subset of the entries in an index where the `term` is in the collection of `terms` in a search phrase.
* `inverse document frequency (iDft)` - a normalized measure of how rare a `term` is in the corpus. It is defined as `log (N / dft)`, where N is the total number of terms in the index. The `iDft` of a rare term is high, whereas the `iDft` of a frequent term is likely to be low.
* `Jaccard index` measures similarity between finite sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets (from [Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index)).
* `JSON` is an acronym for `"Java Script Object Notation"`, a common format for persisting data.
* `k-gram` - a sequence of (any) k consecutive characters from a `term`. A `k-gram` can start with "$", denoting the start of the term, and end with "$", denoting the end of the term. The 3-grams for "castle" are { $ca, cas, ast, stl, tle, le$ }.
* `lemmatizer` - lemmatisation (or lemmatization) in linguistics is the process of grouping together the inflected forms of a word so they can be analysed as a single item, identified by the word's lemma, or dictionary form (from [Wikipedia](https://en.wikipedia.org/wiki/Lemmatisation)).
* `Natural language processing (NLP)` is a subfield of linguistics, computer science, and artificial intelligence concerned with the interactions between computers and human language, in particular how to program computers to process and analyze large amounts of natural language data (from [Wikipedia](https://en.wikipedia.org/wiki/Natural_language_processing)).
* `postings` - a separate index that records which `documents` the `vocabulary` occurs in.  In a positional `index`, the postings also records the positions of each `term` in the `text` to create a positional inverted `index`.
* `postings list` - a record of the positions of a `term` in a `document`. A position of a `term` refers to the index of the `term` in an array that contains all the `terms` in the `text`. In a zoned `index`, the `postings lists` records the positions of each `term` in the `text` a `zone`.
* `term` - a word or phrase that is indexed from the `corpus`. The `term` may differ from the actual word used in the corpus depending on the `tokenizer` used.
* `term filter` - filters unwanted terms from a collection of terms (e.g. stopwords), breaks compound terms into separate terms and / or manipulates terms by invoking a `stemmer` and / or `lemmatizer`.
* `stemmer` -  stemming is the process of reducing inflected (or sometimes derived) words to their word stem, base or root form—generally a written word form (from [Wikipedia](https://en.wikipedia.org/wiki/Stemming)).
* `stopwords` - common words in a language that are excluded from indexing.
* `term expansion` - finding terms with similar spelling (e.g. spelling correction) or synonyms for a term. 
* `term frequency (Ft)` - the frequency of a `term` in an index or indexed object.
* `term position` - the zero-based index of a `term` in an ordered array of `terms` tokenized from the `corpus`.
* `text` - the indexable content of a `document`.
* `token` - representation of a `term` in a text source returned by a `tokenizer`. The token may include information about the `term` such as its position(s) (`term position`) in the text or frequency of occurrence (`term frequency`).
* `token filter` - returns a subset of `tokens` from the tokenizer output.
* `tokenizer` - a function that returns a collection of `token`s from `text`, after applying a character filter, `term` filter, [stemmer](https://en.wikipedia.org/wiki/Stemming) and / or [lemmatizer](https://en.wikipedia.org/wiki/Lemmatisation).
* `vocabulary` - the collection of `terms` indexed from the `corpus`.
* `zone` - the field or zone of a document that a term occurs in, used for parametric indexes or where scoring and ranking of search results attribute a higher score to documents that contain a term in a specific zone (e.g. the title rather that the body of a document).

## References

* [Manning, Raghavan and Schütze, "*Introduction to Information Retrieval*", Cambridge University Press, 2008](https://nlp.stanford.edu/IR-book/pdf/irbookprint.pdf)
* [University of Cambridge, 2016 "*Information Retrieval*", course notes, Dr Ronan Cummins, 2016](https://www.cl.cam.ac.uk/teaching/1516/InfoRtrv/)
* [Wikipedia (1), "*Inverted Index*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Inverted_index)
* [Wikipedia (2), "*Lemmatisation*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Lemmatisation)
* [Wikipedia (3), "*Stemming*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Stemming)
* [Wikipedia (4), "*Synonym*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Synonym)
* [Wikipedia (5), "*Jaccard Index*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Jaccard_index)
* [Wikipedia (6), "*Flesch–Kincaid readability tests*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)
* [Wikipedia (7), "*Edit distance*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Edit_distance)
* [Wikipedia (8), "*Damerau–Levenshtein distance*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance)
* [Wikipedia (9), "*Natural language processing*", from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Natural_language_processing)

## Issues

If you find a bug please fill an [issue](https://github.com/GM-Consult-Pty-Ltd/dictosaurus/issues).  

This project is a supporting package for a revenue project that has priority call on resources, so please be patient if we don't respond immediately to issues or pull requests.


