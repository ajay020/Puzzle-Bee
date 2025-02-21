import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/puzzle_repository.dart';
import 'puzzle_event.dart';
import 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  final PuzzleRepository puzzleRepository;

  PuzzleBloc({required this.puzzleRepository}) : super(PuzzleInitial()) {
    on<LoadPuzzlesByCategoryAndType>(_onLoadPuzzlesByCategoryAndType);
  }

  Future<void> _onLoadPuzzlesByCategoryAndType(
    LoadPuzzlesByCategoryAndType event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(PuzzleLoading());
    try {
      final puzzles = await puzzleRepository.getPuzzlesByCategoryAndType(
        category: event.category,
        type: event.type,
      );
      emit(PuzzleLoaded(puzzles));
    } catch (e) {
      emit(PuzzleError(e.toString()));
    }
  }
}
