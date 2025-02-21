import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puzzle_bee/core/enums/puzzle_type.dart';
import 'package:puzzle_bee/data/repositories/auth_repository.dart';
import 'package:puzzle_bee/data/services/user_cache_service.dart';
import '../../core/enums/puzzle_category.dart';
import '../../domain/repositories/puzzle_repository.dart';
import '../models/puzzle/puzzle.dart';
import '../services/puzzle_cache_service.dart';

class PuzzleRepositoryImpl implements PuzzleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "puzzles";
  final UserCacheService _userCacheService = UserCacheService();
  final AuthRepository _authRepository = AuthRepository();
  final PuzzleCacheService _puzzleCacheService = PuzzleCacheService();

  @override
  Future<List<Puzzle>> getPuzzlesByCategoryAndType({
    required PuzzleCategory category,
    required PuzzleType type,
    DocumentSnapshot? lastDocument, // 🔹 For pagination
    int pageSize = 100, // 🔹 Fetch in small pages
  }) async {
    final solvedPuzzles = await _getSolvedPuzzleIds();

    // ✅ Fetch unsolved puzzles from Hive first
    final List<Puzzle> localPuzzles =
        _puzzleCacheService.getUnsolvedPuzzles(category, type, solvedPuzzles);

    if (localPuzzles.isNotEmpty) {
      return localPuzzles.take(5).toList();
    }

    // 🔹 If not enough puzzles in Hive, fetch from Firestore
    Query query = _firestore
        .collection(collectionPath)
        .where('category', isEqualTo: category.name)
        .where('type', isEqualTo: type.name)
        .orderBy('id')
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot snapshot = await query.get();

    List<Puzzle> fetchedPuzzles = snapshot.docs
        .map((doc) => Puzzle.fromJson(doc.data() as Map<String, dynamic>))
        .where((puzzle) => !solvedPuzzles.contains(puzzle.id))
        .toList();

    // ✅ If not enough puzzles, fetch next page
    while (fetchedPuzzles.length < 100 && snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
      snapshot = await _firestore
          .collection(collectionPath)
          .where('category', isEqualTo: category.name)
          .where('type', isEqualTo: type.name)
          .orderBy('id')
          .startAfterDocument(lastDocument)
          .limit(pageSize)
          .get();

      List<Puzzle> nextBatch = snapshot.docs
          .map((doc) => Puzzle.fromJson(doc.data() as Map<String, dynamic>))
          .where((puzzle) => !solvedPuzzles.contains(puzzle.id))
          .toList();

      fetchedPuzzles.addAll(nextBatch);
    }

    // ✅ Save fetched puzzles to Hive using PuzzleCacheService
    _puzzleCacheService.savePuzzles(fetchedPuzzles);

    return fetchedPuzzles.take(5).toList();
  }

  // Get IDs of solved puzzles
  Future<List<String>> _getSolvedPuzzleIds() async {
    final userId = _authRepository.currentUser?.uid;
    if (userId == null) return [];

    return (await _userCacheService.getUser(userId))?.solvedPuzzles ?? [];
  }
}
