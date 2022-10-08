// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// ignore_for_file: unused_import

// import the core interfaces, classes and mixins
import 'package:dictosaurus/dictosaurus.dart';

// import the typedefs if needed
import 'package:dictosaurus/type_definitions.dart';
import 'package:gmconsult_dev/gmconsult_dev.dart';

//
import '../impl/global.dart';

void main() async {
  // run the README.md example(s)
  await _readMeExample();

  // _seperator();
}

// Simple example(s) for the README.md file.
Future<void> _readMeExample() async {
  //

  final results = <JSON>[];

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

  results.add(
      {'Method': 'suggestionsFor("$misspeltterm")', 'TestResult': corrections});
  results.add({'Method': 'expandTerm("$term")', 'TestResult': expansions});
  results.add({'Method': 'definitionsFor("$term")', 'TestResult': definitions});
  results.add({'Method': 'synonymsOf("$term")', 'TestResult': synonyms});
  results.add({'Method': 'antonymsOf("$term")', 'TestResult': antonyms});
  results.add({'Method': 'inflectionsOf("$term")', 'TestResult': inflections});
  results.add({'Method': 'phrasesWith("$term")', 'TestResult': phrases});

  Console.out(title: '[DictoSaurus] METHODS EXAMPLE', results: results);

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
}

// Print separator
// ignore: unused_element
void _seperator() {
  print(''.padRight(80, '-'));
  print('');
}
