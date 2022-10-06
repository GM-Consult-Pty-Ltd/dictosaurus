// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// Function definition of an asynchronous callback that returns the meaning of
/// a [term] from a dictionary provider.
typedef DictionaryCallback = Future<DictionaryEntry> Function(String term);

/// Function definition of an asynchronous callback that returns the synonyms of
/// a [term] from a thesaurus provider.
typedef SynonymsCallback = Future<Set<String>> Function(String term);
