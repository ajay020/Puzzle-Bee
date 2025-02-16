import '../entites/user_entity.dart';

abstract class UserRepository {
  Future<List<User>> getLeaderboard();
  Future<void> updateUserScore(User user);
}
