import 'package:equatable/equatable.dart';
import '../../../data/models/puzzle/puzzle.dart';

abstract class PuzzleState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial State
class PuzzleInitial extends PuzzleState {}

// Loading state
class PuzzleLoading extends PuzzleState {}

// Loaded state (list of puzzles)
class PuzzleLoaded extends PuzzleState {
  final List<Puzzle> puzzles;

  PuzzleLoaded(this.puzzles);

  @override
  List<Object> get props => [puzzles];
}

// Error state
class PuzzleError extends PuzzleState {
  final String message;

  PuzzleError(this.message);

  @override
  List<Object> get props => [message];
}
