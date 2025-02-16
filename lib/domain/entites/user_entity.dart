class User {
  final String userId;
  final String username;
  final int totalScore;
  final int multipleChoiceScore;
  final int matchingPairsScore;

  User({
    required this.userId,
    required this.username,
    required this.totalScore,
    required this.multipleChoiceScore,
    required this.matchingPairsScore,
  });
}
