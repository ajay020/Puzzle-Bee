import 'package:hive/hive.dart';

import '../models/user/user_model.dart';

class UserCacheService {
  static const String _boxName = 'usersBox';

  /// Opens the Hive box
  Future<Box<UserModel>> _openBox() async {
    return await Hive.openBox<UserModel>(_boxName);
  }

  /// Saves a user to Hive
  Future<void> saveUser(UserModel user) async {
    final box = await _openBox();
    await box.put(user.userId, user);
  }

  /// Retrieves a user from Hive
  Future<UserModel?> getUser(String userId) async {
    final box = await _openBox();
    return box.get(userId);
  }

  /// Updates a user in Hive
  Future<void> updateUser(UserModel user) async {
    final box = await _openBox();
    await box.put(user.userId, user);
  }

  /// Deletes a user from Hive
  Future<void> deleteUser(String userId) async {
    final box = await _openBox();
    await box.delete(userId);
  }

  /// Clears all users from Hive
  Future<void> clearAllUsers() async {
    final box = await _openBox();
    await box.clear();
  }
}
