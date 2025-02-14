import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puzzle_bee/core/enums/puzzle_type.dart';
import '../../core/enums/puzzle_category.dart';
import '../../domain/repositories/puzzle_repository.dart';
import '../models/puzzle/puzzle.dart';

class PuzzleRepositoryImpl implements PuzzleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "puzzles";

  @override
  Future<void> updatePuzzle(Puzzle puzzle) async {
    await _firestore
        .collection(collectionPath)
        .doc(puzzle.id)
        .update(puzzle.toJson());
  }

  @override
  Future<void> addPuzzle(Puzzle puzzle) async {
    await _firestore
        .collection(collectionPath)
        .doc(puzzle.id)
        .set(puzzle.toJson());
  }

  @override
  Future<List<Puzzle>> getPuzzles() async {
    QuerySnapshot snapshot = await _firestore.collection(collectionPath).get();
    return snapshot.docs
        .map((doc) => Puzzle.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> deletePuzzle(String puzzleId) async {
    await _firestore.collection(collectionPath).doc(puzzleId).delete();
  }

  @override
  Future<List<Puzzle>> getPuzzlesByCategoryAndType({
    required PuzzleCategory category,
    required PuzzleType type,
  }) async {
    // Query Firestore for puzzles matching the category and type
    QuerySnapshot snapshot = await _firestore
        .collection(collectionPath)
        .where('category',
            isEqualTo: category.name) // Assuming `category` has a `name` field
        .where('type', isEqualTo: type.name) // Convert type to string
        .get();

    // Map the documents to Puzzle objects
    return snapshot.docs
        .map((doc) => Puzzle.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
