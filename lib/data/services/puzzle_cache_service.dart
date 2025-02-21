import 'package:hive/hive.dart';

import '../../core/enums/puzzle_category.dart';
import '../../core/enums/puzzle_type.dart';
import '../models/puzzle/puzzle.dart';

class PuzzleCacheService {
  final Box<Puzzle> _puzzleBox = Hive.box<Puzzle>('puzzles');

  // ✅ Save puzzles in Hive
  void savePuzzles(List<Puzzle> puzzles) {
    for (var puzzle in puzzles) {
      _puzzleBox.put(puzzle.id, puzzle);
    }
  }

  // ✅ Get unsolved puzzles from Hive
  List<Puzzle> getUnsolvedPuzzles(
      PuzzleCategory category, PuzzleType type, List<String> solvedPuzzles) {
    return _puzzleBox.values
        .where((puzzle) =>
            puzzle.category == category &&
            puzzle.type == type &&
            !solvedPuzzles.contains(puzzle.id)) // ✅ Exclude solved puzzles
        .toList();
  }
}
