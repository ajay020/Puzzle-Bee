import 'package:flutter/material.dart';
import 'package:puzzle_bee/presentation/screens/main_screen.dart';

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
