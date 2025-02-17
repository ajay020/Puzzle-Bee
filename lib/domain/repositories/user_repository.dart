import 'package:puzzle_bee/data/models/user/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getLeaderboard();
  Future<UserModel?> fetchUserProfile(String userId);
  Future<void> updateUserScore({
    required String userId,
    required Map<String, dynamic> updates,
  });
}
