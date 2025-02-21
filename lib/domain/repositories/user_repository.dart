import 'package:puzzle_bee/data/models/user/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getLeaderboard();
  Future<void> updateUserScore({
    required String userId,
    required Map<String, dynamic> updates,
  });
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String userId);
  Future<void> updateUser(UserModel user);
}
