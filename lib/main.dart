import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_bee/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/core/theme/theme_provider.dart';
import 'package:puzzle_bee/data/models/puzzle/pair_item.dart'
    show PairItemAdapter;
import 'package:puzzle_bee/data/models/puzzle/puzzle.dart';
import 'package:puzzle_bee/data/repositories/puzzle_repository_impl.dart';
import 'package:puzzle_bee/data/repositories/user_repository_impl.dart';
import 'package:puzzle_bee/data/services/user_cache_service.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_event.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_event.dart';
import 'package:puzzle_bee/presentation/blocs/user/user_bloc.dart';

import 'data/models/puzzle/match_pairs_content.dart';
import 'data/models/puzzle/multiple_choice_content.dart';
import 'data/models/puzzle/puzzle_content.dart';
import 'data/models/user/user_model.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/blocs/puzzle/puzzle_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //upload puzzles to firestore
  // await uploadPuzzlesToFirestore();

  await Hive.initFlutter();

  Hive.registerAdapter(PuzzleAdapter());
  Hive.registerAdapter(MultipleChoiceContentAdapter());
  Hive.registerAdapter(MatchPairsContentAdapter());
  Hive.registerAdapter(PairItemAdapter());
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<Puzzle>('puzzles');

  final puzzleRepository = PuzzleRepositoryImpl();
  final userRepository = UserRepositoryImpl(
    firestore: FirebaseFirestore.instance,
    cacheService: UserCacheService(),
  );
  final authRepository = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<AuthRepository>.value(value: authRepository)
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
              create: (context) => UserBloc(userRepository: userRepository)),
          BlocProvider(
            create: (context) => LeaderboardBloc(userRepository: userRepository)
              ..add(LoadLeaderboard()),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
