// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// ignore: unused_import
import 'package:dictosaurus/dictosaurus.dart';
import 'package:dictosaurus/src/_index.dart';

import 'data/kgram_index.dart';
// import 'data/synonyms_index.dart';

void main() async {
  // run the README.md example(s)
  await _readMeExample(kGramIndex);

  // _seperator();
}

// Simple example(s) for the README.md file.
Future<void> _readMeExample(Map<String, Set<String>> kGramIndex) async {
  //
  // print a heading
  print('README.md EXAMPLE');

  // define a misspelt term
  final term = 'aple';

  // initialize a `AutoCorrect` instance
  final autoCorrect = AutoCorrect.inMemory(kGramIndex);

  // get autocorrect suggestions for the term
  final suggestions = await autoCorrect.suggestionsFor(term, 10);

  // print the autocorrect suggestions
  print(suggestions);

  // // initialize a `Thesaurus` instance.
  // final thesaurus = Thesaurus.inMemory(synonymsIndex);

  // // print synonyms for "Tesla"
  // print(await thesaurus.synonymsOf('tesla'));

  // define a starts-with sequence of characters
  final startsWith = 'te';

  // get the terms in the kgram-index that start with "aap"
  final startsWithTerms = await autoCorrect.startsWith(startsWith);

// print the terms in the kgram-index that start with "aap"
  print(startsWithTerms);
}

// Print separator
// ignore: unused_element
void _seperator() {
  print(''.padRight(80, '-'));
  print('');
}
