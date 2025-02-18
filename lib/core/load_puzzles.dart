import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, dynamic>>> loadPuzzles() async {
  try {
    String jsonString = await rootBundle.loadString('assets/puzzles.json');
    List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.cast<Map<String, dynamic>>();
  } catch (e) {
    print("Error loading puzzles: $e");
    return [];
  }
}
