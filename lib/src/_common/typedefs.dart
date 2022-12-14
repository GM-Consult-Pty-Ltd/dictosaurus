// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:text_analysis/text_analysis.dart';
import 'package:dictosaurus/src/_index.dart';
import 'package:gmconsult_dart_core/dart_core.dart';

/// Function definition of an asynchronous callback that returns the properties
/// of a [term] from a dictionary provider or API.
typedef DictionaryCallback = Future<DictionaryEntry?> Function(String term);

/// Function definition of an asynchronous callback that returns an expansion of
/// a [term] from an asynchronous provider or API.
typedef TermExpander = Future<Set<String>> Function(String term,
    [PartOfSpeech? partOfSpeech]);

/// Returns translations for [term] from [sourceLanguage] to [targetLanguage]
/// as a collection of [TermVariant]s.
typedef TranslationCallback = Future<Set<TermVariant>> Function(
    String term, Language sourceLanguage, Language targetLanguage);
