import 'package:flutter/material.dart';
import 'package:puzzle_bee/core/enums/puzzle_category.dart';
import 'package:puzzle_bee/core/enums/puzzle_type.dart';
import 'package:puzzle_bee/data/repositories/mock_puzzle_repository.dart';
import 'package:puzzle_bee/presentation/screens/main_screen.dart';
import 'package:puzzle_bee/presentation/screens/match_pair_puzzle_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PuzzleBee",
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
