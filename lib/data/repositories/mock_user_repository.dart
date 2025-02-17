import 'package:puzzle_bee/data/models/user/user_model.dart';

import '../../domain/entites/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  final List<UserModel> _mockUsers = [
    UserModel(
      userId: "user1",
      username: "PuzzleMaster",
      photoURL: "",
      totalScore: 2800,
      multipleChoiceScore: 1500,
      matchingPairsScore: 1300,
    ),
    UserModel(
      userId: "user2",
      username: "BrainTeaser",
      photoURL: "",
      totalScore: 2500,
      multipleChoiceScore: 1200,
      matchingPairsScore: 1300,
    ),
    UserModel(
      userId: "user3",
      username: "QuizWhiz",
      photoURL: "",
      totalScore: 2300,
      multipleChoiceScore: 1400,
      matchingPairsScore: 900,
    ),
    UserModel(
      userId: "user4",
      username: "PuzzleKing",
      photoURL: "",
      totalScore: 2100,
      multipleChoiceScore: 1000,
      matchingPairsScore: 1100,
    ),
    UserModel(
      userId: "user5",
      username: "MindBender",
      photoURL: "",
      totalScore: 2000,
      multipleChoiceScore: 900,
      matchingPairsScore: 1100,
    ),
    UserModel(
      userId: "user6",
      username: "LogicPro",
      photoURL: "",
      totalScore: 1900,
      multipleChoiceScore: 800,
      matchingPairsScore: 1100,
    ),
    UserModel(
      userId: "user7",
      username: "RiddleMaster",
      photoURL: "",
      totalScore: 1800,
      multipleChoiceScore: 1000,
      matchingPairsScore: 800,
    ),
    UserModel(
      userId: "user8",
      username: "QuizMaster",
      photoURL: "",
      totalScore: 1700,
      multipleChoiceScore: 900,
      matchingPairsScore: 800,
    ),
  ];

  @override
  Future<List<UserModel>> getLeaderboard() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 800));
    return _mockUsers;
  }

  // @override
  // Future<void> updateUserScore(UserModel user) async {
  //   // Simulate network delay
  //   await Future.delayed(Duration(milliseconds: 500));

  //   final index = _mockUsers.indexWhere((u) => u.userId == user.userId);
  //   if (index != -1) {
  //     _mockUsers[index] = user;
  //   } else {
  //     _mockUsers.add(user);
  //   }

  //   // Sort users by total score after update
  //   _mockUsers.sort((a, b) => b.totalScore.compareTo(a.totalScore));
  // }

  @override
  Future<UserModel?> fetchUserProfile(String userId) async {
    UserModel currUser = UserModel(
      userId: "11",
      username: "Ajay",
      photoURL: "photoURL",
      totalScore: 100,
      multipleChoiceScore: 10,
      matchingPairsScore: 10,
    );

    return currUser;
  }

  @override
  Future<void> updateUserScore(
      {required String userId, required Map<String, dynamic> updates}) {
    // TODO: implement updateUserScore
    throw UnimplementedError();
  }
}
