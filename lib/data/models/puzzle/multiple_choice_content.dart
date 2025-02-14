import 'package:puzzle_bee/core/enums/puzzle_type.dart';

import 'puzzle_content.dart';

class MultipleChoiceContent extends PuzzleContent {
  final List<String> options;
  final int correctOptionIndex;

  MultipleChoiceContent({
    required super.question,
    required this.options,
    required this.correctOptionIndex,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'correctOptionIndex': correctOptionIndex,
      };

  factory MultipleChoiceContent.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceContent(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
    );
  }
}
