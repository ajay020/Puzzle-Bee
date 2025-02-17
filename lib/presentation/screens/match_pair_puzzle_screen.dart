import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/data/models/puzzle/match_pairs_content.dart';
import 'package:puzzle_bee/data/models/puzzle/pair_item.dart';
import '../../core/firestore_fields.dart';
import '../../data/models/puzzle/puzzle.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/leaderboard/leaderboard_bloc.dart';
import '../blocs/leaderboard/leaderboard_event.dart';

class MatchingPairsPuzzleScreen extends StatefulWidget {
  final List<Puzzle> puzzles;

  const MatchingPairsPuzzleScreen({required this.puzzles, super.key});

  @override
  State<MatchingPairsPuzzleScreen> createState() =>
      _MatchingPairsPuzzleScreenState();
}

class _MatchingPairsPuzzleScreenState extends State<MatchingPairsPuzzleScreen> {
  late List<PairItem> pairs;
  late List<String> leftItems;
  late List<String> rightItems;
  String? selectedLeftItem; // Track selected left item
  String? selectedRightItem; // Track selected right item
  Set<String> matchedPairs = {}; // Track matched pairs
  Set<String> unmatchedPairs = {};
  int timeLeft = 30; // 30-second timer
  late Timer timer;
  int currentPuzzleIndex = 0;

  @override
  void initState() {
    super.initState();
    // Extract pairs from the puzzle content
    final puzzle = widget.puzzles[currentPuzzleIndex];

    // Check if the content is of type MatchPairsContent
    if (puzzle.content is! MatchPairsContent) {
      return;
    }

    final content = puzzle.content as MatchPairsContent;
    pairs = content.pairs;

    // Shuffle the left and right items
    leftItems = pairs.map((pair) => pair.leftItem).toList()..shuffle();
    rightItems = pairs.map((pair) => pair.rightItem).toList()..shuffle();

    // Start the timer
    startTimer();
  }

  void _moveToNextPuzzle() {
    if (currentPuzzleIndex < widget.puzzles.length - 1) {
      setState(() {
        currentPuzzleIndex++;
        timeLeft = 30;
        matchedPairs.clear();
        selectedLeftItem = null;
        selectedRightItem = null;

        // Reinitialize the puzzle content for the next puzzle
        final puzzle = widget.puzzles[currentPuzzleIndex];
        if (puzzle.content is MatchPairsContent) {
          final content = puzzle.content as MatchPairsContent;
          pairs = content.pairs;
          leftItems = pairs.map((pair) => pair.leftItem).toList()..shuffle();
          rightItems = pairs.map((pair) => pair.rightItem).toList()..shuffle();
        }

        // Restart the timer
        startTimer();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You completed all puzzles! 🎉"),
          duration: Duration(seconds: 2),
        ),
      );
      // Completed all puzzles. Go back to home.
      Navigator.pop(context);
    }
  }

  int calculateMatchingPairsScore(int correctPairs, int timeLeft) {
    int baseScore = correctPairs * 5; // 5 points per correct pair
    int timeBonus = timeLeft; // 1 point per second remaining
    return baseScore + timeBonus;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _onItemTapped(String item, bool isLeftItem) {
    setState(() {
      if (isLeftItem) {
        if (selectedLeftItem == item) {
          selectedLeftItem = null; // Deselect if already selected
        } else {
          selectedLeftItem = item;
        }
      } else {
        if (selectedRightItem == item) {
          selectedRightItem = null; // Deselect if already selected
        } else {
          selectedRightItem = item;
        }
      }

      // Check if one item from left and one from right are selected
      if (selectedLeftItem != null && selectedRightItem != null) {
        _checkMatch(selectedLeftItem!, selectedRightItem!);
      }
    });
  }

  void _checkMatch(String leftItem, String rightItem) {
    final pair = pairs.firstWhere(
      (pair) => pair.leftItem == leftItem && pair.rightItem == rightItem,
      orElse: () => PairItem(id: '', leftItem: '', rightItem: ''),
    );

    if (pair.id.isNotEmpty) {
      // Correct match
      setState(() {
        matchedPairs.add(leftItem);
        matchedPairs.add(rightItem);
      });
    } else {
      // Incorrect match
      setState(() {
        unmatchedPairs.add(leftItem);
        unmatchedPairs.add(rightItem);
      });

      // Show red color for incorrect pair for 1 second
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          unmatchedPairs.clear();
        });
      });
    }

    // Clear selections after checking
    selectedLeftItem = null;
    selectedRightItem = null;

    // Check if all pairs are matched
    if (matchedPairs.length == pairs.length * 2) {
      timer.cancel();
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    // Calculate score
    final score = calculateMatchingPairsScore(pairs.length, timeLeft);

    // Get the current user from AuthBloc
    final user = (context.read<AuthBloc>().state as Authenticated).userData;

    // Prepare the updates
    final updates = {
      FirestoreFields.totalScore: FieldValue.increment(score),
      FirestoreFields.matchingPairsScore: FieldValue.increment(score),
    };

    // Dispatch the UpdateScore event to the LeaderboardBloc
    context
        .read<LeaderboardBloc>()
        .add(UpdateScore(userId: user.userId, updates: updates));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text("You scored $score points!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // go home
            },
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog first
              _moveToNextPuzzle(); // Then move to the next puzzle
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time’s Up!'),
        content: const Text('You couldn’t solve the puzzle in time.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Replay the puzzle
              setState(() {
                timeLeft = 30;
                matchedPairs.clear();
                selectedLeftItem = null;
                selectedRightItem = null;
                leftItems.shuffle();
                rightItems.shuffle();
              });
              startTimer();
            },
            child: const Text('Replay'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Go back to home
              Navigator.pop(context);
            },
            child: const Text('Home'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Pairs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer and Progress Bar
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: timeLeft / 30,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$timeLeft sec',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              (widget.puzzles.first.content as MatchPairsContent).question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  // Left column (left items)
                  Expanded(child: _createColumn(leftItems, true)),
                  const SizedBox(width: 20),
                  // Right column (right items)
                  Expanded(child: _createColumn(rightItems, false)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String item) {
    if (matchedPairs.contains(item)) {
      return Colors.green;
    } else if (unmatchedPairs.contains(item)) {
      return Colors.red;
    } else if (selectedLeftItem == item || selectedRightItem == item) {
      return Colors.blue;
    } else {
      return Colors.grey[300]!;
    }
  }

  Widget _createColumn(List<String> items, bool isLeftItem) {
    return ListView(
      children: items.map((item) {
        return GestureDetector(
          onTap: () => _onItemTapped(item, isLeftItem),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getColor(item),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
