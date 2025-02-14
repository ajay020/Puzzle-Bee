import 'package:flutter/cupertino.dart';

import '../../core/enums/puzzle_category.dart';
import '../../core/enums/puzzle_type.dart';

class PuzzleThumbnail {
  final String title;
  final PuzzleCategory category;
  final PuzzleType type;
  final IconData icon;

  PuzzleThumbnail({
    required this.title,
    required this.category,
    required this.type,
    required this.icon,
  });
}
