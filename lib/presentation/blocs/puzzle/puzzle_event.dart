import 'package:equatable/equatable.dart';
import '../../../core/enums/puzzle_category.dart';
import '../../../core/enums/puzzle_type.dart';
import '../../../data/models/puzzle/puzzle.dart';

abstract class PuzzleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Load puzzles from Firestore
class LoadPuzzles extends PuzzleEvent {}

// Load puzzles by category and type
class LoadPuzzlesByCategoryAndType extends PuzzleEvent {
  final PuzzleCategory category;
  final PuzzleType type;

  LoadPuzzlesByCategoryAndType({required this.category, required this.type});

  @override
  List<Object> get props => [category, type];
}

// Add a new puzzle
class AddPuzzle extends PuzzleEvent {
  final Puzzle puzzle;

  AddPuzzle(this.puzzle);

  @override
  List<Object> get props => [puzzle];
}

// Update an existing puzzle
class UpdatePuzzle extends PuzzleEvent {
  final Puzzle puzzle;

  UpdatePuzzle(this.puzzle);

  @override
  List<Object> get props => [puzzle];
}

// Delete a puzzle
class DeletePuzzle extends PuzzleEvent {
  final String puzzleId;

  DeletePuzzle(this.puzzleId);

  @override
  List<Object> get props => [puzzleId];
}
