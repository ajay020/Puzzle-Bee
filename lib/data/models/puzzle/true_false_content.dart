import 'puzzle_content.dart';

class TrueFalseContent extends PuzzleContent {
  final bool correctAnswer;

  TrueFalseContent({
    required super.question,
    required this.correctAnswer,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'correctAnswer': correctAnswer,
      };

  factory TrueFalseContent.fromJson(Map<String, dynamic> json) {
    return TrueFalseContent(
      question: json['question'],
      correctAnswer: json['correctAnswer'],
    );
  }
}
