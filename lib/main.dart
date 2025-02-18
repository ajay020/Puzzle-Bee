import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_bee/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/core/upload_puzzles.dart';
import 'package:puzzle_bee/data/repositories/mock_puzzle_repository.dart';
import 'package:puzzle_bee/data/repositories/puzzle_repository_impl.dart';
import 'package:puzzle_bee/data/repositories/user_repository_impl.dart';
import 'package:puzzle_bee/domain/repositories/puzzle_repository.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_event.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_event.dart';

import 'data/repositories/auth_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/blocs/puzzle/puzzle_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //upload puzzles to firestore
  // await uploadPuzzlesToFirestore();

  final puzzleRepository = PuzzleRepositoryImpl();
  final userRepository = UserRepositoryImpl(
    firestore: FirebaseFirestore.instance,
  );
  final authRepository = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: authRepository,
              userRepository: userRepository,
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => PuzzleBloc(puzzleRepository: puzzleRepository),
          ),
          BlocProvider(
            create: (context) => LeaderboardBloc(userRepository: userRepository)
              ..add(LoadLeaderboard()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
