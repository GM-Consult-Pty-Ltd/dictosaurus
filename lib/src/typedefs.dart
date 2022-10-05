// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

import 'package:dictosaurus/src/_index.dart';

/// Maps the words in a language (synonymsIndex) to a collection of unique
/// synonyms. The synonyms collection can be empty.
///
/// Alias for `Map<Term, Set<Term>>`.
typedef SynonymsMap = Map<Term, Set<Term>>;
