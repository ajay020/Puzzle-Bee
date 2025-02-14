// lib/data/datasources/firebase_datasource.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/errors/failures.dart';
import '../models/puzzle/puzzle.dart';
import '../models/user_progress.dart';

class FirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _puzzlesCollection =>
      _firestore.collection('puzzles');
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Get all puzzles
  Future<List<Puzzle>> getPuzzles() async {
    try {
      final QuerySnapshot snapshot = await _puzzlesCollection.get();
      return snapshot.docs
          .map((doc) => Puzzle.fromJson(
              {'id': doc.id, ...doc.data() as Map<String, dynamic>}))
          .toList();
    } catch (e) {
      throw DatabaseFailure('Failed to fetch puzzles: ${e.toString()}');
    }
  }

  // Get puzzles by category
  Future<List<Puzzle>> getPuzzlesByCategory(String category) async {
    try {
      final QuerySnapshot snapshot =
          await _puzzlesCollection.where('category', isEqualTo: category).get();
      return snapshot.docs
          .map((doc) => Puzzle.fromJson(
              {'id': doc.id, ...doc.data() as Map<String, dynamic>}))
          .toList();
    } catch (e) {
      throw DatabaseFailure(
          'Failed to fetch puzzles by category: ${e.toString()}');
    }
  }

  // Get single puzzle
  Future<Puzzle> getPuzzle(String puzzleId) async {
    try {
      final DocumentSnapshot doc = await _puzzlesCollection.doc(puzzleId).get();
      if (!doc.exists) {
        throw DatabaseFailure('Puzzle not found');
      }
      return Puzzle.fromJson(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw DatabaseFailure('Failed to fetch puzzle: ${e.toString()}');
    }
  }

  // Create new puzzle
  Future<void> createPuzzle(Puzzle puzzle) async {
    try {
      await _puzzlesCollection.doc(puzzle.id).set(puzzle.toJson());
    } catch (e) {
      throw DatabaseFailure('Failed to create puzzle: ${e.toString()}');
    }
  }

  // Update puzzle
  Future<void> updatePuzzle(Puzzle puzzle) async {
    try {
      await _puzzlesCollection.doc(puzzle.id).update(puzzle.toJson());
    } catch (e) {
      throw DatabaseFailure('Failed to update puzzle: ${e.toString()}');
    }
  }

  // Delete puzzle
  Future<void> deletePuzzle(String puzzleId) async {
    try {
      await _puzzlesCollection.doc(puzzleId).delete();
    } catch (e) {
      throw DatabaseFailure('Failed to delete puzzle: ${e.toString()}');
    }
  }

  // Get user progress
  Future<UserProgress> getUserProgress(String userId) async {
    try {
      final DocumentSnapshot doc = await _usersCollection.doc(userId).get();
      if (!doc.exists) {
        // Return new user progress if user doesn't exist
        return UserProgress(
          userId: userId,
          completedPuzzles: {},
          totalScore: 0,
        );
      }
      return UserProgress.fromJson(
          {'userId': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw DatabaseFailure('Failed to fetch user progress: ${e.toString()}');
    }
  }

  // Update user progress
  Future<void> updateUserProgress(UserProgress progress) async {
    try {
      await _usersCollection.doc(progress.userId).set(progress.toJson());
    } catch (e) {
      throw DatabaseFailure('Failed to update user progress: ${e.toString()}');
    }
  }

  // Update puzzle score
  Future<void> updatePuzzleScore(
    String userId,
    String puzzleId,
    int score,
  ) async {
    try {
      // Get current progress
      UserProgress progress = await getUserProgress(userId);

      // Update completed puzzles map
      final updatedCompletedPuzzles =
          Map<String, int>.from(progress.completedPuzzles);
      updatedCompletedPuzzles[puzzleId] = score;

      // Calculate new total score
      final newTotalScore =
          updatedCompletedPuzzles.values.reduce((a, b) => a + b);

      // Create updated progress
      final updatedProgress = UserProgress(
        userId: userId,
        completedPuzzles: updatedCompletedPuzzles,
        totalScore: newTotalScore,
      );

      // Save to Firebase
      await updateUserProgress(updatedProgress);
    } catch (e) {
      throw DatabaseFailure('Failed to update puzzle score: ${e.toString()}');
    }
  }

  // Batch get puzzles by IDs
  Future<List<Puzzle>> getPuzzlesByIds(List<String> puzzleIds) async {
    try {
      if (puzzleIds.isEmpty) return [];

      // Firestore limits batched reads to 10 documents
      const batchSize = 10;
      List<Puzzle> puzzles = [];

      for (var i = 0; i < puzzleIds.length; i += batchSize) {
        final end = (i + batchSize < puzzleIds.length)
            ? i + batchSize
            : puzzleIds.length;
        final batch = puzzleIds.sublist(i, end);

        final QuerySnapshot snapshot = await _puzzlesCollection
            .where(FieldPath.documentId, whereIn: batch)
            .get();

        puzzles.addAll(
          snapshot.docs.map((doc) => Puzzle.fromJson(
              {'id': doc.id, ...doc.data() as Map<String, dynamic>})),
        );
      }

      return puzzles;
    } catch (e) {
      throw DatabaseFailure('Failed to fetch puzzles by IDs: ${e.toString()}');
    }
  }
}
