import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 6) // Use a unique typeId
class UserModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String? photoURL;

  @HiveField(3)
  final int totalScore;

  @HiveField(4)
  final int multipleChoiceScore;

  @HiveField(5)
  final int matchingPairsScore;

  @HiveField(6)
  final List<String> solvedPuzzles;

  UserModel({
    required this.userId,
    required this.username,
    this.photoURL = "",
    this.totalScore = 0,
    this.multipleChoiceScore = 0,
    this.matchingPairsScore = 0,
    this.solvedPuzzles = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      photoURL: json['photoURL'] ?? '',
      totalScore: json['totalScore'] ?? 0,
      multipleChoiceScore: json['multipleChoiceScore'] ?? 0,
      matchingPairsScore: json['matchingPairsScore'] ?? 0,
      solvedPuzzles:
          (json['solvedPuzzles'] as List<dynamic>?)?.cast<String>() ?? [],
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
      'solvedPuzzles': solvedPuzzles,
    };
  }

  /// Copy user model and update specific fields
  UserModel copyWith({
    String? userId,
    String? username,
    String? photoURL,
    int? totalScore,
    int? multipleChoiceScore,
    int? matchingPairsScore,
    List<String>? solvedPuzzles,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      photoURL: photoURL ?? this.photoURL,
      totalScore: totalScore ?? this.totalScore,
      multipleChoiceScore: multipleChoiceScore ?? this.multipleChoiceScore,
      matchingPairsScore: matchingPairsScore ?? this.matchingPairsScore,
      solvedPuzzles: solvedPuzzles ?? this.solvedPuzzles,
    );
  }
}
