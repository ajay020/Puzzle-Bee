import 'package:flutter/material.dart';

import '../data/models/puzzle_thumbnail.dart';
import 'enums/puzzle_category.dart';
import 'enums/puzzle_type.dart';

List<PuzzleThumbnail> puzzleThumbnails = [
  PuzzleThumbnail(
    title: "Match pair",
    category: PuzzleCategory.english,
    type: PuzzleType.matchingPairs,
    icon: Icons.spellcheck,
  ),
  PuzzleThumbnail(
    title: "Multiple choice",
    category: PuzzleCategory.english,
    type: PuzzleType.multipleChoice,
    icon: Icons.calculate,
  ),
  PuzzleThumbnail(
    title: "Match Pair",
    category: PuzzleCategory.math,
    type: PuzzleType.matchingPairs,
    icon: Icons.bolt_sharp,
  ),
  PuzzleThumbnail(
    title: "Multiple choice",
    category: PuzzleCategory.math,
    type: PuzzleType.multipleChoice,
    icon: Icons.calculate,
  ),
];
