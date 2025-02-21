import 'package:puzzle_bee/core/enums/puzzle_category.dart';
import 'package:puzzle_bee/core/enums/puzzle_type.dart';

import '../../data/models/puzzle/puzzle.dart';

abstract class PuzzleRepository {
  Future<List<Puzzle>> getPuzzlesByCategoryAndType({
    required PuzzleCategory category,
    required PuzzleType type,
  });
}
