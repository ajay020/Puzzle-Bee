import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/user_repository.dart';
import '../models/user/user_model.dart';
import '../services/user_cache_service.dart' show UserCacheService;

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  final UserCacheService cacheService;

  UserRepositoryImpl({required this.firestore, required this.cacheService});

  @override
  Future<List<UserModel>> getLeaderboard() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .orderBy('totalScore', descending: true)
          .limit(10)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch leaderboard data');
    }
  }

  @override
  Future<void> updateUserScore({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      throw Exception('Failed to update user score: $e');
    }
  }

  /// Retrieves a user from Hive first, if not found, fetches from Firestore
  @override
  Future<UserModel?> getUser(String userId) async {
    UserModel? user = await cacheService.getUser(userId);

    if (user == null) {
      // Fetch from Firestore
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        user = UserModel.fromJson(doc.data()!);
        await cacheService.saveUser(user); // Save locally
      }
    }
    return user;
  }

  /// Saves a user both locally and to Firestore
  @override
  Future<void> saveUser(UserModel user) async {
    await cacheService.saveUser(user);
    await firestore
        .collection('users')
        .doc(user.userId)
        .set(user.toJson(), SetOptions(merge: true));
  }

  /// Updates a user's solved puzzles and scores in both Hive & Firestore
  @override
  Future<void> updateUser(UserModel updatedUser) async {
    // Save to cache
    await cacheService.updateUser(updatedUser);
    // Save to firestore
    await firestore.collection('users').doc(updatedUser.userId).set(
          updatedUser.toJson(),
          SetOptions(merge: true),
        );
  }
}
