import 'package:hive/hive.dart';
import 'package:puzzle_bee/data/models/puzzle/pair_item.dart';

import 'puzzle_content.dart';

part 'match_pairs_content.g.dart';

@HiveType(typeId: 3)
class MatchPairsContent extends PuzzleContent {
  @override
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<PairItem> pairs;

  MatchPairsContent({
    required this.question,
    required this.pairs,
  }) : super(question: question);

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
