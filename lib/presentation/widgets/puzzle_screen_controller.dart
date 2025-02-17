import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/screens/match_pair_puzzle_screen.dart';
import '../../core/enums/puzzle_category.dart';
import '../../core/enums/puzzle_type.dart';
import '../../data/models/puzzle/puzzle.dart';
import '../blocs/puzzle/puzzle_block.dart';
import '../blocs/puzzle/puzzle_event.dart';
import '../blocs/puzzle/puzzle_state.dart';
import '../screens/multiple_choice_puzzle_screen.dart';

class PuzzleScreen extends StatefulWidget {
  final PuzzleCategory category;
  final PuzzleType type;

  const PuzzleScreen({
    required this.category,
    required this.type,
    super.key,
  });

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Dispatch the event to fetch puzzles based on category and type
    context.read<PuzzleBloc>().add(
          LoadPuzzlesByCategoryAndType(
            category: widget.category,
            type: widget.type,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleBloc, PuzzleState>(
      builder: (context, state) {
        if (state is PuzzleInitial || state is PuzzleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PuzzleError) {
          return Center(child: Text(state.message));
        } else if (state is PuzzleLoaded) {
          return _buildPuzzleScreenByType(state.puzzles);
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _buildPuzzleScreenByType(List<Puzzle> puzzles) {
    // Filter puzzles to ensure they match the current type
    final filteredPuzzles =
        puzzles.where((puzzle) => puzzle.type == widget.type).toList();

    if (filteredPuzzles.isEmpty) {
      return const Center(child: Text('No puzzles found for this type'));
    }

    switch (widget.type) {
      case PuzzleType.multipleChoice:
        return MultipleChoicePuzzleScreen(puzzles: puzzles);
      case PuzzleType.matchingPairs:
        return MatchingPairsPuzzleScreen(puzzles: puzzles);
      case PuzzleType.trueFalse:
        return const Text("True false");
      default:
        return const Text("Unknown type");
    }
  }
}
