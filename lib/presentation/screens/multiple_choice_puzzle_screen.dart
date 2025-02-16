import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/screens/result_screen.dart';

import '../../data/models/puzzle/multiple_choice_content.dart';
import '../../data/models/puzzle/puzzle.dart';
import '../../domain/entites/user_entity.dart';
import '../blocs/leaderboard/leaderboard_bloc.dart';
import '../blocs/leaderboard/leaderboard_event.dart';

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
  int _timeLeft = 10; // 30 seconds for each question

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _moveToNextPuzzle();
        }
      });
    });
  }

  void _moveToNextPuzzle() {
    if (currentPuzzleIndex < widget.puzzles.length - 1) {
      setState(() {
        currentPuzzleIndex++;
        selectedOptionIndex = null;
        isAnswerSubmitted = false;
        _timeLeft = 10; // Reset timer for the next question
      });
    } else {
      int correctAnsers = _calculateCorrectAnswers();
      final multipleChoiceScore =
          calculateMultipleChoiceScore(correctAnsers, _timeLeft);
      final updatedUser = User(
        userId: 'user123', // Replace with the actual user ID
        username: 'Current User', // Replace with the actual user name
        totalScore: multipleChoiceScore,
        multipleChoiceScore: multipleChoiceScore, // Update based on puzzle type
        matchingPairsScore: 0, // Update based on puzzle type
      );

      // Dispatch the UpdateScore event to the LeaderboardBloc
      context.read<LeaderboardBloc>().add(UpdateScore(updatedUser));

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
            LinearProgressIndicator(
              minHeight: 12.0,
              value: _timeLeft / 10,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
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
