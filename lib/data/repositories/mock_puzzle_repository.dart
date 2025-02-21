import 'package:puzzle_bee/core/enums/puzzle_category.dart';
import 'package:puzzle_bee/core/enums/puzzle_type.dart';
import 'package:puzzle_bee/domain/repositories/puzzle_repository.dart';

import '../data_sources/mock_puzzle_data.dart';
import '../models/puzzle/puzzle.dart';

class MockPuzzleRepository implements PuzzleRepository {
  final List<Puzzle> _puzzles = MockPuzzleData.getMockPuzzles();
  final Map<String, int> _userProgress = MockPuzzleData.getMockUserProgress();

  @override
  Future<List<Puzzle>> getPuzzles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _puzzles;
  }

  @override
  Future<List<Puzzle>> getPuzzlesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _puzzles.where((puzzle) => puzzle.category == category).toList();
  }

  @override
  Future<void> updateProgress(String userId, String puzzleId, int score) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _userProgress[puzzleId] = score;
  }

  @override
  Future<List<Puzzle>> getPuzzlesByCategoryAndType({
    required PuzzleCategory category,
    required PuzzleType type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _puzzles
        .where((puzzle) =>
            puzzle.category.name == category.name &&
            puzzle.type.name == type.name)
        .toList();
  }
}
