import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_bee/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/data/repositories/mock_puzzle_repository.dart';

import 'presentation/blocs/puzzle/puzzle_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final puzzleRepository = MockPuzzleRepository();

  runApp(
    BlocProvider(
      create: (context) => PuzzleBloc(puzzleRepository: puzzleRepository),
      child: const MyApp(),
    ),
  );
}
