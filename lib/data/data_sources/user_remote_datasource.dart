import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSource(this._firestore);

  Future<List<UserModel>> getLeaderboard() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .orderBy('score', descending: true)
          .limit(100)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch leaderboard data');
    }
  }

  Future<void> updateUserScore(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(
            user.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw Exception('Failed to update user score');
    }
  }

  // Fetch the current user's profile data
  Future<UserModel?> fetchUserProfile(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) return null;

      return UserModel.fromJson(userDoc.data()!);
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
