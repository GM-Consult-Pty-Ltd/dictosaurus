// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// ignore: unused_import
import 'package:dictosaurus/dictosaurus.dart';
import 'package:test/test.dart';
import 'data/kGramIndex.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('autocorrect', () async {
      final autoCorrect = AutoCorrect.inMemory(vocabularykGrams);
      final term = 'apple';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await autoCorrect.suggestionsFor(term, 50);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });
  });
}
