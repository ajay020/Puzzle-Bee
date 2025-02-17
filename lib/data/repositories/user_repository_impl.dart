import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/user_repository.dart';
import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

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

  // Fetch the current user's profile data
  @override
  Future<UserModel?> fetchUserProfile(String userId) async {
    try {
      final userDoc = await firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) return null;

      return UserModel.fromJson(userDoc.data()!);
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
