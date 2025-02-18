import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PuzzleCacheService {
  final SharedPreferences _prefs;
  final FirebaseFirestore _firestore;

  // Keys for SharedPreferences
  static const String _cachedPuzzlesKey = 'cached_puzzles';
  static const String _leaderboardKey = 'leaderboard';
  static const String _lastLeaderboardUpdateKey = 'last_leaderboard_update';

  PuzzleCacheService(this._prefs, this._firestore);

  // Fetch and cache puzzles
  Future<List<Map<String, dynamic>>> fetchAndCachePuzzles({
    required String category,
    String? difficulty,
    int batchSize = 10,
  }) async {
    // Check if we have cached puzzles
    final cachedPuzzles = getCachedPuzzles(category);
    if (cachedPuzzles.length >= batchSize) {
      return cachedPuzzles;
    }

    // Fetch new puzzles from Firebase
    final query = _firestore
        .collection('puzzles')
        .where('category', isEqualTo: category)
        .limit(batchSize);

    if (difficulty != null) {
      query.where('difficulty', isEqualTo: difficulty);
    }

    final puzzlesDocs = await query.get();
    final puzzles = puzzlesDocs.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList();

    // Cache the puzzles
    await cachePuzzles(category, puzzles);

    return puzzles;
  }

  // Get cached puzzles
  List<Map<String, dynamic>> getCachedPuzzles(String category) {
    final cachedData = _prefs.getString(_cachedPuzzlesKey);
    if (cachedData == null) return [];

    final Map<String, dynamic> allCachedPuzzles = json.decode(cachedData);
    return List<Map<String, dynamic>>.from(allCachedPuzzles[category] ?? []);
  }

  // Cache puzzles
  Future<void> cachePuzzles(
      String category, List<Map<String, dynamic>> puzzles) async {
    final cachedData = _prefs.getString(_cachedPuzzlesKey);
    final Map<String, dynamic> allCachedPuzzles =
        cachedData != null ? json.decode(cachedData) : {};

    allCachedPuzzles[category] = puzzles;
    await _prefs.setString(_cachedPuzzlesKey, json.encode(allCachedPuzzles));
  }

  // Fetch and cache leaderboard
  Future<List<Map<String, dynamic>>> fetchAndCacheLeaderboard() async {
    final lastUpdate = _prefs.getString(_lastLeaderboardUpdateKey);
    final now = DateTime.now();

    // Check if we need to update the leaderboard
    if (lastUpdate != null) {
      final lastUpdateDate = DateTime.parse(lastUpdate);
      if (now.difference(lastUpdateDate).inDays < 1) {
        return getCachedLeaderboard();
      }
    }

    // Fetch new leaderboard data
    final leaderboardDocs = await _firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .limit(100)
        .get();

    final leaderboard = leaderboardDocs.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList();

    // Cache the leaderboard
    await _prefs.setString(_leaderboardKey, json.encode(leaderboard));
    await _prefs.setString(_lastLeaderboardUpdateKey, now.toIso8601String());

    return leaderboard;
  }

  // Get cached leaderboard
  List<Map<String, dynamic>> getCachedLeaderboard() {
    final cachedData = _prefs.getString(_leaderboardKey);
    if (cachedData == null) return [];
    return List<Map<String, dynamic>>.from(json.decode(cachedData));
  }

  // Clear cache (useful for debugging or when user logs out)
  Future<void> clearCache() async {
    await _prefs.remove(_cachedPuzzlesKey);
    await _prefs.remove(_leaderboardKey);
    await _prefs.remove(_lastLeaderboardUpdateKey);
  }
}
