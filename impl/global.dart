// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';
import 'package:gmconsult_dev/test_data.dart';
import 'package:text_indexing/text_indexing.dart';

import 'oxford_dictionary.dart';

const k = 2;

Future<InvertedIndex> getIndex() async {
  final data = TestData.stockNews;
  final index = InMemoryIndex(
      analyzer: English(),
      collectionSize: data.length,
      // keywordExtractor: English.analyzer.keywordExtractor,
      zones: {'name': 1, 'descriptions': 0.5},
      k: k);
  // final indexer = TextIndexer(index);
  await index.indexCollection(data);
  return index;
}

Future<DictoSaurus> getDictoSaurus([Dictionary? dictionary]) async {
  final index = await getIndex();
  return DictoSaurus.fromComponents(
      dictionary: dictionary ?? OxfordDictionaries(),
      autoCorrect: AutoCorrect.kGram(index.getKGramIndex, k: k));
}

Future<Iterable<Token>> tokenizer(String term, [String? zone]) async =>
    [Token(term, 1, 0)];
