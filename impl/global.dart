// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/dictosaurus.dart';
import 'package:gmconsult_dev/test_data.dart';
import 'oxford_dictionary.dart';

const k = 2;

Future<InvertedIndex> getIndex() async {
  final index = InMemoryIndex(
      tokenizer: TextTokenizer(),
      zones: {'name': 1, 'descriptions': 0.5},
      k: k);
  final indexer = TextIndexer(index: index);
  await indexer.indexCollection(TestData.stockNews);
  return index;
}

Future<DictoSaurus> getDictoSaurus() async {
  final index = await getIndex();
  return DictoSaurus(
      dictionary: OxfordDictionaries(),
      autoCorrect: AutoCorrect(index.getKGramIndex, k: k));
}

Future<Iterable<Token>> tokenizer(String term, [String? zone]) async =>
    [Token(term, 0)];