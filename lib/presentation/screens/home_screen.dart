import 'package:flutter/material.dart';
import 'package:puzzle_bee/core/enums/puzzle_category.dart';
import 'package:puzzle_bee/core/puzzle_thumbails.dart';
import 'package:puzzle_bee/data/models/puzzle_thumbnail.dart';

import '../widgets/puzzle_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PuzzleCategory currentPuzzleCategory = PuzzleCategory.english;

  void _navigateToPuzzle(BuildContext context, PuzzleThumbnail puzzle) {
    // Navigate to puzzle list screen with selected category & type
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PuzzleScreen(
          category: currentPuzzleCategory,
          type: puzzle.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter the list based on the current category
    final puzzleThumbnailList = puzzleThumbnails
        .where((puzzle) => puzzle.category.name == currentPuzzleCategory.name)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PuzzleBee'),
      ),
      body: Column(
        children: [
          // category selection buttons
          SegmentedButton<PuzzleCategory>(
            segments: [
              ButtonSegment(
                value: PuzzleCategory.english,
                label: Text("English"),
              ),
              ButtonSegment(
                value: PuzzleCategory.math,
                label: Text("Math"),
              ),
            ],
            selected: {currentPuzzleCategory},
            onSelectionChanged: (newValue) {
              setState(() {
                currentPuzzleCategory = newValue.first;
              });
            },
          ),

          const SizedBox(height: 18),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: puzzleThumbnailList.length,
              itemBuilder: (context, index) {
                var puzzleThumnail = puzzleThumbnailList[index];

                return PuzzleCard(
                  puzzleThumbnail: puzzleThumnail,
                  onTap: () {
                    _navigateToPuzzle(context, puzzleThumnail);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// presentation/widgets/puzzle_card.dart
class PuzzleCard extends StatelessWidget {
  final PuzzleThumbnail puzzleThumbnail;
  final VoidCallback onTap;

  const PuzzleCard({
    super.key,
    required this.puzzleThumbnail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 120,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(puzzleThumbnail.icon),
              const SizedBox(height: 12),
              Text(
                puzzleThumbnail.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
