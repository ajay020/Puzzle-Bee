import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

Future<void> uploadPuzzlesToFirestore() async {
  try {
    // Load JSON file
    String jsonString = await rootBundle.loadString('assets/puzzles.json');
    List<dynamic> puzzles = json.decode(jsonString);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference puzzlesCollection = firestore.collection('puzzles');

    WriteBatch batch = firestore.batch();
    int batchCounter = 0;

    for (var puzzle in puzzles) {
      String puzzleId = puzzle['id'];

      // Create document reference
      DocumentReference puzzleDoc = puzzlesCollection.doc(puzzleId);

      batch.set(puzzleDoc, puzzle);
      batchCounter++;

      // Commit batch every 500 writes (Firestore limit)
      if (batchCounter == 500) {
        await batch.commit();
        batch = firestore.batch(); // Start a new batch
        batchCounter = 0;
      }
    }

    // Commit remaining puzzles
    if (batchCounter > 0) {
      await batch.commit();
    }
  } catch (e) {
    throw Exception('Failed to upload puzzles: $e');
  }
}
