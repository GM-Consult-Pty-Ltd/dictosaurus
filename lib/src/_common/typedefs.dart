// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

// import 'package:dictosaurus/dictosaurus.dart';
import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// Function definition of an asynchronous callback that returns the properties
/// of a [term] from a dictionary provider or API.
///
/// Optionally specify the [endpoint] to include in the returned
/// [TermProperties] instance, useful where different API endpoints are
/// queried for specific properties.
typedef DictionaryCallback = Future<TermProperties?> Function(String term,
    [DictionaryEndpoint? endpoint]);

/// Function definition of an asynchronous callback that returns an expansion of
/// a [term] from an asynchronous provider or API.
typedef TermExpander = Future<Set<String>> Function(String term,
    [PartOfSpeech? partOfSpeech]);

/// Returns translations for [term] from [sourceLanguage] to as
/// [TermProperties].
typedef TranslationCallback = Future<TermProperties?> Function(
    String term, Language sourceLanguage);
