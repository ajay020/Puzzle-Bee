import 'package:puzzle_bee/core/enums/puzzle_type.dart';

import '../../core/enums/puzzle_category.dart';
import '../models/puzzle/puzzle.dart';
import '../models/puzzle/multiple_choice_content.dart';
import '../models/puzzle/true_false_content.dart';
import '../models/puzzle/fill_blank_content.dart';
import '../models/puzzle/match_pairs_content.dart';
import '../models/puzzle/pair_item.dart';

class MockPuzzleData {
  static List<Puzzle> getMockPuzzles() {
    return [
      Puzzle(
        id: 'math_mc_1',
        title: 'Basic Addition',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.arithmetic,
        type: PuzzleType.multipleChoice,
        content: MultipleChoiceContent(
          question: 'What is 15 + 7?',
          options: ['21', '22', '23', '24'],
          correctOptionIndex: 1,
        ),
      ),
      Puzzle(
        id: 'math_mc_2',
        title: 'Multiplication',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.arithmetic,
        type: PuzzleType.multipleChoice,
        content: MultipleChoiceContent(
          question: 'What is 12 × 8?',
          options: ['88', '92', '96', '98'],
          correctOptionIndex: 2,
        ),
      ),
      // Math True/False Puzzles
      Puzzle(
        id: 'math_tf_1',
        title: 'Number Properties',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.arithmetic,
        type: PuzzleType.trueFalse,
        content: TrueFalseContent(
          question: 'Every even number is divisible by 2.',
          correctAnswer: true,
        ),
      ),

      Puzzle(
        id: 'math_tf_2',
        title: 'Geometry Facts',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.equations,
        type: PuzzleType.trueFalse,
        content: TrueFalseContent(
          question:
              'A square is always a rectangle, but a rectangle is not always a square.',
          correctAnswer: true,
        ),
      ),

      // Math Match Pairs Puzzles
      Puzzle(
        id: 'math_mp_1',
        title: 'Number Pairs',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.arithmetic,
        type: PuzzleType.matchingPairs,
        content: MatchPairsContent(
          question: 'Match each number with its double:',
          pairs: [
            PairItem(id: '1', leftItem: '7', rightItem: '14'),
            PairItem(id: '2', leftItem: '9', rightItem: '18'),
            PairItem(id: '3', leftItem: '11', rightItem: '22'),
          ],
        ),
      ),
      Puzzle(
        id: 'math_mp_2',
        title: 'Equation Pairs',
        category: PuzzleCategory.math,
        subCategory: MathSubCategory.equations,
        type: PuzzleType.matchingPairs,
        content: MatchPairsContent(
          question: 'Match each equation with its result:',
          pairs: [
            PairItem(id: '1', leftItem: '3 × 4', rightItem: '12'),
            PairItem(id: '2', leftItem: '20 ÷ 5', rightItem: '4'),
            PairItem(id: '3', leftItem: '7 + 8', rightItem: '15'),
          ],
        ),
      ),

      // English Match Pairs Puzzles
      Puzzle(
        id: 'eng_mp_1',
        title: 'Antonym Pairs',
        category: PuzzleCategory.english,
        subCategory: EnglishSubCategory.antonyms,
        type: PuzzleType.matchingPairs,
        content: MatchPairsContent(
          question: 'Match each word with its opposite:',
          pairs: [
            PairItem(id: '1', leftItem: 'hot', rightItem: 'cold'),
            PairItem(id: '2', leftItem: 'big', rightItem: 'small'),
            PairItem(id: '3', leftItem: 'fast', rightItem: 'slow'),
          ],
        ),
      ),
      // English Multiple Choice Puzzles
      Puzzle(
        id: 'eng_mc_1',
        title: 'Synonyms',
        category: PuzzleCategory.english,
        subCategory: EnglishSubCategory.synonyms,
        type: PuzzleType.multipleChoice,
        content: MultipleChoiceContent(
          question: 'What is a synonym for "happy"?',
          options: ['sad', 'joyful', 'angry', 'tired'],
          correctOptionIndex: 1,
        ),
      ),
      // English Fill in the Blank Puzzles
      Puzzle(
        id: 'eng_fb_1',
        title: 'Common Phrases',
        category: PuzzleCategory.english,
        subCategory: EnglishSubCategory.vocabulary,
        type: PuzzleType.fillInTheBlank,
        content: FillBlankContent(
          question: "Time flies when you're having ___.",
          correctAnswer: 'fun',
          acceptableAnswers: ['Fun', 'FUN'],
        ),
      ),
      Puzzle(
        id: 'eng_fb_2',
        title: 'Proverbs',
        category: PuzzleCategory.english,
        subCategory: EnglishSubCategory.vocabulary,
        type: PuzzleType.fillInTheBlank,
        content: FillBlankContent(
          question: 'A bird in hand is worth ___ in the bush.',
          correctAnswer: 'two',
          acceptableAnswers: ['Two', 'TWO', '2'],
        ),
      ),
    ];
  }

  // Mock user progress
  static Map<String, int> getMockUserProgress() {
    return {
      'math_mc_1': 10,
      'eng_mc_1': 10,
      'math_tf_1': 5,
    };
  }
}
