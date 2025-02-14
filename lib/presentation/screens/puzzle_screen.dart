import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/screens/multiple_choice_puzzle_screen.dart';
import '../../core/enums/puzzle_category.dart';
import '../../core/enums/puzzle_type.dart';
import '../blocs/puzzle_block.dart';
import '../blocs/puzzle_event.dart';
import '../blocs/puzzle_state.dart';

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
          if (widget.type == PuzzleType.multipleChoice) {
            return MultipleChoicePuzzleScreen(puzzles: state.puzzles);
          } else if (widget.type == PuzzleType.matchingPairs) {
            return Text("Match the pairs");
          } else if (widget.type == PuzzleType.trueFalse) {
            return Text("True false ");
          } else {
            return Text("Unkonwn type");
          }
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
