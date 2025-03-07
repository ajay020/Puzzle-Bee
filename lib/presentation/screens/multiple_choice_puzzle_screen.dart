import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/screens/result_screen.dart';

import '../../data/models/puzzle/multiple_choice_content.dart';
import '../../data/models/puzzle/puzzle.dart';
import '../../data/models/user/user_model.dart';
import '../../domain/repositories/user_repository.dart' show UserRepository;
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/user/user_bloc.dart' show UserBloc;
import '../blocs/user/user_event.dart';
import '../widgets/common/progressbar.dart';

class MultipleChoicePuzzleScreen extends StatefulWidget {
  final List<Puzzle> puzzles;

  const MultipleChoicePuzzleScreen({required this.puzzles, super.key});

  @override
  State<MultipleChoicePuzzleScreen> createState() =>
      _MultipleChoicePuzzleScreenState();
}

class _MultipleChoicePuzzleScreenState
    extends State<MultipleChoicePuzzleScreen> {
  int currentPuzzleIndex = 0;
  List<int?> selectedAnswers = []; // Track selected answers for all puzzles
  int? selectedOptionIndex;
  bool isAnswerSubmitted = false;
  Timer? _timer;
  double _timeLeft = 20; // Example: 20 seconds timer
  final double totalTime = 20;
  List<String> correctPuzzleIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selectedAnswers list with null values
    selectedAnswers = List.filled(widget.puzzles.length, null);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft -= .1;
        } else {
          _moveToNextPuzzle();
        }
      });
    });
  }

  void _moveToNextPuzzle() async {
    if (currentPuzzleIndex < widget.puzzles.length - 1) {
      setState(() {
        currentPuzzleIndex++;
        selectedOptionIndex = null;
        isAnswerSubmitted = false;
        _timeLeft = 10; // Reset timer for the next question
      });
    } else {
      int correctAnsers = _calculateCorrectAnswers();
      final score =
          calculateMultipleChoiceScore(correctAnsers, _timeLeft.toInt());

      // Get the current user from AuthBloc
      final authUser =
          (context.read<AuthBloc>().state as Authenticated).authUser;
      final userRepository = context.read<UserRepository>();
      final user = await userRepository.getUser(authUser.uid);

      if (!mounted) return; // ✅ Check if widget is still in the tree

      UserModel updatedUser = user!.copyWith(
        totalScore: user.totalScore + score,
        multipleChoiceScore: user.multipleChoiceScore + score,
        solvedPuzzles: [...user.solvedPuzzles, ...correctPuzzleIds],
      );

      context.read<UserBloc>().add(UpdateUser(updatedUser));

      // Navigate to the result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalQuestions: widget.puzzles.length,
            correctAnswers: correctAnsers,
          ),
        ),
      );
    }
  }

  int calculateMultipleChoiceScore(int correctAnswers, int timeLeft) {
    int baseScore = correctAnswers * 10; // 10 points per correct answer
    int timeBonus = timeLeft; // 1 point per second remaining
    return baseScore + timeBonus;
  }

  int _calculateCorrectAnswers() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.puzzles.length; i++) {
      if (widget.puzzles[i].content is MultipleChoiceContent) {
        final content = widget.puzzles[i].content as MultipleChoiceContent;
        if (selectedAnswers[i] == content.correctOptionIndex) {
          correctAnswers++;
          correctPuzzleIds.add(widget.puzzles[i].id);
        }
      }
    }
    return correctAnswers;
  }

  void _onOptionSelected(int index) {
    if (!isAnswerSubmitted) {
      setState(() {
        selectedAnswers[currentPuzzleIndex] =
            index; // Store the selected answer
        isAnswerSubmitted = true;
      });

      // Move to the next puzzle after a short delay
      Future.delayed(const Duration(seconds: 1), _moveToNextPuzzle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = widget.puzzles[currentPuzzleIndex];
    // Check if the content is of type MultipleChoiceContent
    if (puzzle.content is! MultipleChoiceContent) {
      return const Center(child: Text('Invalid puzzle type'));
    }
    final content = puzzle.content as MultipleChoiceContent;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Question ${currentPuzzleIndex + 1}/${widget.puzzles.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProgressBar(
              currentTime: _timeLeft,
              totalTime: totalTime,
              height: 12.0,
              backgroundColor: Colors.grey[300]!,
              progressColor: Colors.green,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                content.question,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...content.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return GestureDetector(
                onTap: () => _onOptionSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _getOptionColor(index),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(option),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color? _getOptionColor(int index) {
    if (!isAnswerSubmitted) {
      return null;
    }
    final content =
        widget.puzzles[currentPuzzleIndex].content as MultipleChoiceContent;
    if (index == content.correctOptionIndex) {
      return Colors.green; // Correct answer
    } else if (index == selectedAnswers[currentPuzzleIndex]) {
      return Colors.red; // Incorrect answer
    }
    return null;
  }
}
