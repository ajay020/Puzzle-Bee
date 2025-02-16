class UserModel {
  final String userId;
  final String username;
  final int totalScore;
  final int multipleChoiceScore;
  final int matchingPairsScore;

  UserModel({
    required this.userId,
    required this.username,
    required this.totalScore,
    required this.multipleChoiceScore,
    required this.matchingPairsScore,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      totalScore: json['totalScore'] ?? 0,
      multipleChoiceScore: json['multipleChoiceScore'] ?? 0,
      matchingPairsScore: json['matchingPairsScore'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'score': totalScore,
      'multipleChoiceScore': multipleChoiceScore,
      'matchingPairsScore': matchingPairsScore,
    };
  }

  UserModel copyWith({
    String? userId,
    String? username,
    int? totalScore,
    int? multipleChoiceScore,
    int? matchingPairsScore,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      totalScore: totalScore ?? this.totalScore,
      multipleChoiceScore: multipleChoiceScore ?? this.multipleChoiceScore,
      matchingPairsScore: matchingPairsScore ?? this.matchingPairsScore,
    );
  }
}
