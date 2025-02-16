import '../../domain/entites/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  final List<User> _mockUsers = [
    User(
      userId: "user1",
      username: "PuzzleMaster",
      totalScore: 2800,
      multipleChoiceScore: 1500,
      matchingPairsScore: 1300,
    ),
    User(
      userId: "user2",
      username: "BrainTeaser",
      totalScore: 2500,
      multipleChoiceScore: 1200,
      matchingPairsScore: 1300,
    ),
    User(
      userId: "user3",
      username: "QuizWhiz",
      totalScore: 2300,
      multipleChoiceScore: 1400,
      matchingPairsScore: 900,
    ),
    User(
      userId: "user4",
      username: "PuzzleKing",
      totalScore: 2100,
      multipleChoiceScore: 1000,
      matchingPairsScore: 1100,
    ),
    User(
      userId: "user5",
      username: "MindBender",
      totalScore: 2000,
      multipleChoiceScore: 900,
      matchingPairsScore: 1100,
    ),
    User(
      userId: "user6",
      username: "LogicPro",
      totalScore: 1900,
      multipleChoiceScore: 800,
      matchingPairsScore: 1100,
    ),
    User(
      userId: "user7",
      username: "RiddleMaster",
      totalScore: 1800,
      multipleChoiceScore: 1000,
      matchingPairsScore: 800,
    ),
    User(
      userId: "user8",
      username: "QuizMaster",
      totalScore: 1700,
      multipleChoiceScore: 900,
      matchingPairsScore: 800,
    ),
  ];

  @override
  Future<List<User>> getLeaderboard() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 800));
    return _mockUsers;
  }

  @override
  Future<void> updateUserScore(User user) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    final index = _mockUsers.indexWhere((u) => u.userId == user.userId);
    if (index != -1) {
      _mockUsers[index] = user;
    } else {
      _mockUsers.add(user);
    }

    // Sort users by total score after update
    _mockUsers.sort((a, b) => b.totalScore.compareTo(a.totalScore));
  }
}
