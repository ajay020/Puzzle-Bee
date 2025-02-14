class UserProgress {
  final String userId;
  final Map<String, int> completedPuzzles; // puzzle_id -> score
  final int totalScore;

  UserProgress({
    required this.userId,
    required this.completedPuzzles,
    required this.totalScore,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'completedPuzzles': completedPuzzles,
        'totalScore': totalScore,
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'],
      completedPuzzles: Map<String, int>.from(json['completedPuzzles']),
      totalScore: json['totalScore'],
    );
  }
}
