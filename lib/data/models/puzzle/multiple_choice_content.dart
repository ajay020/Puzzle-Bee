import 'package:hive/hive.dart';

import 'puzzle_content.dart';

part 'multiple_choice_content.g.dart';

@HiveType(typeId: 2)
class MultipleChoiceContent extends PuzzleContent {
  @override
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<String> options;

  @HiveField(2)
  final int correctOptionIndex;

  MultipleChoiceContent({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  }) : super(question: question);

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
