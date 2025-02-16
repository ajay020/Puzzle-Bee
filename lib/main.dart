import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_bee/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/data/repositories/mock_puzzle_repository.dart';
import 'package:puzzle_bee/data/repositories/mock_user_repository.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_event.dart';

import 'presentation/blocs/puzzle/puzzle_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final puzzleRepository = MockPuzzleRepository();
  final userRepository = MockUserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PuzzleBloc(puzzleRepository: puzzleRepository),
        ),
        BlocProvider(
          create: (context) => LeaderboardBloc(userRepository: userRepository)
            ..add(LoadLeaderboard()),
        )
      ],
      child: const MyApp(),
    ),
  );
}
