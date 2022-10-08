// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// ignore_for_file: unused_local_variable

@Timeout(Duration(minutes: 5))

// import the core classes
import 'package:dictosaurus/dictosaurus.dart';
import '../impl/oxford_dictionary.dart';
import '../impl/global.dart';
import 'package:test/test.dart';

void main() {
  group('Dictionary', (() {
    //

    test('Dictionary', (() async {
      final term = 'smart';
      final dictionary = OxfordDictionaries();
      final definitions = await dictionary.definitionsFor(term);
      final inflections = await dictionary.inflectionsOf(term);
      final phrases = await dictionary.phrasesWith(term);
      print('Thesaurus methods on "$term":');
      print('Definitions:   $definitions');
      print('Inflections:   $inflections');
      print('Phrases:       $phrases');
    }));
  }));
  group('Thesaurus', (() {
    //

    test('Thesaurus()', (() async {
      final term = 'swim';
      final dictionary = OxfordDictionaries();
      final thesaurus = Thesaurus.dictionary(dictionary);
      final synonyms = await thesaurus.synonymsOf(term);
      final antonyms = await thesaurus.antonymsOf(term);
      print('Thesaurus methods on "$term":');
      print('Synonyms:      $synonyms');
      print('Antonyms:      $antonyms');
    }));
  }));
  group('Autocorrect', () {
    setUp(() async {});

    test('autocorrect', () async {
      final index = await getIndex();
      final autoCorrect = AutoCorrect.kGram(index.getKGramIndex, k: k);
      final term = 'aple';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await autoCorrect.suggestionsFor(term, 10);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });

    test('startsWith', () async {
      final index = await getIndex();
      final autoCorrect = AutoCorrect.kGram(index.getKGramIndex, k: k);
      final chars = 'app';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await autoCorrect.startsWith(chars, 5);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });
  });
  group('DictoSaurus', () {
    setUp(() async {});

    test('DictoSaurus.suggestionsFor("aple")', () async {
      final dictoSaurus = await getDictoSaurus();
      final term = 'appel';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await dictoSaurus.suggestionsFor(term, 10);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });

    test('DictoSaurus.startsWith("app")', () async {
      final dictoSaurus = await getDictoSaurus();
      final chars = 'app';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await dictoSaurus.startsWith(chars, 5);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });

    test('DictoSaurus.expandTerm("apple")', () async {
      final dictoSaurus = await getDictoSaurus();
      final term = 'apple';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await dictoSaurus.expandTerm(term, 25);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Expanded $term to $suggestions in $dT seconds.');
    });

    test('DictoSaurus.methods', () async {
      final dictoSaurus = await getDictoSaurus();
      final misspeltterm = 'inteligent';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await dictoSaurus.expandTerm(misspeltterm, 25);
      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;
      // calculate the time taken in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      print('Expanded $misspeltterm to $suggestions in $dT seconds.');
      final term = 'intelligent';
      final synonyms = await dictoSaurus.synonymsOf(term);
      final antonyms = await dictoSaurus.antonymsOf(term);
      final definitions = await dictoSaurus.definitionsFor(term);
      final inflections = await dictoSaurus.inflectionsOf(term);
      final phrases = await dictoSaurus.phrasesWith(term);
      print('Dictosaurus methods on "$term":');
      print('Definitions:   $definitions');
      print('Inflections:   $inflections');
      print('Phrases:       $phrases');
      print('Synonyms:      $synonyms');
      print('Antonyms:      $antonyms');
    });
  });
}
