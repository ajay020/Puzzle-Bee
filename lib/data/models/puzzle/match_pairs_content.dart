import 'package:puzzle_bee/data/models/puzzle/pair_item.dart';

import 'puzzle_content.dart';

class MatchPairsContent extends PuzzleContent {
  final List<PairItem> pairs;

  MatchPairsContent({
    required super.question,
    required this.pairs,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'pairs': pairs.map((pair) => pair.toJson()).toList(),
      };

  factory MatchPairsContent.fromJson(Map<String, dynamic> json) {
    return MatchPairsContent(
      question: json['question'],
      pairs: (json['pairs'] as List)
          .map((pair) => PairItem.fromJson(pair))
          .toList(),
    );
  }
}
