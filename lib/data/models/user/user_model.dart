class UserModel {
  final String userId;
  final String username;
  final String? photoURL;
  final int totalScore;
  final int multipleChoiceScore;
  final int matchingPairsScore;

  UserModel({
    required this.userId,
    required this.username,
    this.photoURL = "",
    this.totalScore = 0,
    this.multipleChoiceScore = 0,
    this.matchingPairsScore = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      photoURL: json['photoURL'] ?? '',
      totalScore: json['totalScore'] ?? 0,
      multipleChoiceScore: json['multipleChoiceScore'] ?? 0,
      matchingPairsScore: json['matchingPairsScore'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'photoURL': photoURL,
      'totalScore': totalScore,
      'multipleChoiceScore': multipleChoiceScore,
      'matchingPairsScore': matchingPairsScore,
    };
  }
}
