// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/type_definitions.dart';
import 'package:gmconsult_dev/gmconsult_dev.dart';
import 'package:hive/hive.dart';

/// A Hive data service that exposes the [getSynonyms] method.
class HiveSynonymService extends HiveJsonService {
  HiveSynonymService(super.dataStore);

  /// Returns a [HiveSynonymService] with [name] at [path] after calling
  /// [Hive.init].
  static Future<HiveSynonymService> hydrate(
      {String path = '', String name = 'synonyms'}) async {
    name = (name.isEmpty ? 'synonyms' : name)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '_');
    path = path
        .toLowerCase()
        .replaceAll(RegExp(r'[\\\/]+'), r'\')
        .replaceAll(RegExp(r'(?<=^)[\/\\]+|[\/\\]+(?=$)'), '');
    Hive.init(path);
    final Box<String> dataStore = await Hive.openBox(name);
    return HiveSynonymService(dataStore);
  }

  /// Returns a [HiveSynonymService].
  ///
  /// Hydrates a [HiveSynonymService] with [name] at [path] after calling
  /// [Hive.init], then populates the [HiveSynonymService] with [synonymsMap].
  static Future<HiveSynonymService> fromSynonymsMap(SynonymsMap synonymsMap,
      {String path = '', String name = 'synonyms'}) async {
    final retVal = await HiveSynonymService.hydrate(path: path, name: name);
    await retVal.populate(synonymsMap);
    return retVal;
  }

  /// Populates the [HiveSynonymService] with [synonymsMap].
  ///
  /// Maps [synonymsMap] to a [JsonCollection] with [JSON] values as a
  /// `Map<String, List<String>>`
  Future<void> populate(SynonymsMap synonymsMap) async {
    final JsonCollection values = synonymsMap.map((key, value) => MapEntry(
        key, <String, dynamic>{'term': key, 'synonyms': value.toList()}));
    await batchUpsert(values);
  }

  @override
  Future<Map<String, Set<String>>?> read(String term) async {
    final json = await super.read(term);
    if (json != null && json['synonyms'] is Iterable) {
      final synonyms = (json['synonyms'] as Iterable).cast<String>().toSet();
      json['synonyms'] = synonyms;
    }
    return json as Map<String, Set<String>>;
  }

  /// Reads all the synonyms for [terms] and maps the values to a [SynonymsMap].
  Future<SynonymsMap> getSynonyms(Iterable<String> terms) async {
    final data = await batchRead(terms);
    final SynonymsMap retVal = {};
    for (final e in data.values) {
      retVal[e['term'] as String] = Set<String>.from(
          (e['synonyms'] as Iterable).map((e) => e.toString()));
    }
    return retVal;
  }
}
