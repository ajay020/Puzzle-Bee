import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/puzzle_repository.dart';
import 'puzzle_event.dart';
import 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  final PuzzleRepository puzzleRepository;

  PuzzleBloc({required this.puzzleRepository}) : super(PuzzleInitial()) {
    on<LoadPuzzles>(_onLoadPuzzles);
    on<LoadPuzzlesByCategoryAndType>(_onLoadPuzzlesByCategoryAndType);
    on<AddPuzzle>(_onAddPuzzle);
    on<UpdatePuzzle>(_onUpdatePuzzle);
    on<DeletePuzzle>(_onDeletePuzzle);
  }

  Future<void> _onLoadPuzzles(
      LoadPuzzles event, Emitter<PuzzleState> emit) async {
    emit(PuzzleLoading());
    try {
      final puzzles = await puzzleRepository.getPuzzles();
      emit(PuzzleLoaded(puzzles));
    } catch (e) {
      emit(PuzzleError(e.toString()));
    }
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

  Future<void> _onAddPuzzle(AddPuzzle event, Emitter<PuzzleState> emit) async {
    try {
      await puzzleRepository.addPuzzle(event.puzzle);
      add(LoadPuzzles()); // Reload puzzles
    } catch (e) {
      emit(PuzzleError(e.toString()));
    }
  }

  Future<void> _onUpdatePuzzle(
      UpdatePuzzle event, Emitter<PuzzleState> emit) async {
    try {
      await puzzleRepository.updatePuzzle(event.puzzle);
      add(LoadPuzzles()); // Reload puzzles
    } catch (e) {
      emit(PuzzleError(e.toString()));
    }
  }

  Future<void> _onDeletePuzzle(
      DeletePuzzle event, Emitter<PuzzleState> emit) async {
    try {
      await puzzleRepository.deletePuzzle(event.puzzleId);
      add(LoadPuzzles()); // Reload puzzles
    } catch (e) {
      emit(PuzzleError(e.toString()));
    }
  }
}
