// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

@Timeout(Duration(minutes: 5))

// import 'package:dictosaurus/src/_index.dart';
import 'package:dictosaurus/dictosaurus.dart';
import 'package:dictosaurus/package_exports.dart';
import 'package:dictosaurus/type_definitions.dart';
import 'package:test/test.dart';
import 'data/sample_news.dart';
import 'data/synonyms_map.dart';
import 'impl/hive_synonym_service.dart';

void main() {
  group('Thesaurus', (() {
    //

    setUp(() async {
      final service = await HiveSynonymService.fromSynonymsMap(synonymsMap,
          path: 'test/data');
      await service.close();
    });

    test('Thesaurus()', (() async {
      final synonymsService =
          await HiveSynonymService.hydrate(path: 'test/data');
      final thesaurus = Thesaurus(synonymsService.getSynonyms);
      print(await thesaurus.synonymsOf('zero'));
    }));

    test('Thesaurus.inMemory()', (() async {
      final thesaurus = Thesaurus.inMemory(synonymsMap, tokenizer: tokenizer);
      print(await thesaurus.synonymsOf('zero'));
    }));
  }));
  group('Dictosaurus', () {
    setUp(() async {});

    test('autocorrect', () async {
      final index = await _getIndex(sampleNews);
      final autoCorrect = AutoCorrect(index.getKGramIndex, k: 3);
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
      final index = await _getIndex(sampleNews);
      final autoCorrect = AutoCorrect(index.getKGramIndex, k: 3);
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
}

Future<InvertedIndex> _getIndex(JsonCollection documents,
    [Map<String, double> zones = const {
      'name': 1,
      'descriptions': 0.5
    }]) async {
  final index = InMemoryIndex(tokenizer: TextTokenizer(), zones: zones, k: 3);
  final indexer = TextIndexer(index: index);
  await indexer.indexCollection(documents);
  return index;
}

Future<Iterable<Token>> tokenizer(String term, [String? zone]) async =>
    [Token(term, 0)];
