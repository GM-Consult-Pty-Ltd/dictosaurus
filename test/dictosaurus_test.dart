// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// ignore: unused_import
import 'package:dictosaurus/dictosaurus.dart';
import 'package:test/test.dart';
import 'data/sample_news.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('autocorrect', () async {
      final index = await _getIndex(sampleNews);
      final autoCorrect = AutoCorrect.async(index.getKGramIndex);
      final term = 'taiwansemicondutcor'.stemPorter2();
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
      final index = await _getIndex(sampleNews);
      final autoCorrect = AutoCorrect.async(index.getKGramIndex);
      final chars = 'app';
      final startTime = DateTime.now();
      final start = startTime.millisecondsSinceEpoch;
      final suggestions = await autoCorrect.startsWith(chars);

      // get the end time in milliseconds
      final end = DateTime.now().millisecondsSinceEpoch;

      // calculate the time taken to index the corpus in milliseconds
      final dT = ((end - start) / 1000).toStringAsFixed(3);
      // print(suggestions);
      print('Retrieved $suggestions in $dT seconds.');
    });
  });
}

Future<InvertedIndex> _getIndex(JsonCollection documents,
    [Map<String, double> zones = const {
      'name': 1,
      'descriptions': 0.5
    }]) async {
  final index = InMemoryIndex(tokenizer: TextTokenizer(), zones: zones);
  final indexer = TextIndexer(index: index);
  await indexer.indexCollection(documents);
  return index;
}
