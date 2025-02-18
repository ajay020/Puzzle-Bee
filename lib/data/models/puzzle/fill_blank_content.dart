
import 'puzzle_content.dart';

class FillBlankContent extends PuzzleContent {
  final String correctAnswer;
  final List<String> acceptableAnswers;

  FillBlankContent({
    required super.question,
    required this.correctAnswer,
    this.acceptableAnswers = const [],
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'correctAnswer': correctAnswer,
        'acceptableAnswers': acceptableAnswers,
      };

  factory FillBlankContent.fromJson(Map<String, dynamic> json) {
    return FillBlankContent(
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      acceptableAnswers: List<String>.from(json['acceptableAnswers'] ?? []),
    );
  }
}
