import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/leaderboard/leaderboard_event.dart';

import '../../../domain/repositories/user_repository.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final UserRepository userRepository;

  LeaderboardBloc({required this.userRepository})
      : super(LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<UpdateScore>(_onUpdateScore);
  }

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(LeaderboardLoading());
    try {
      final users = await userRepository.getLeaderboard();
      emit(LeaderboardLoaded(users));
    } catch (e) {
      emit(LeaderboardError('Failed to load leaderboard'));
    }
  }

  Future<void> _onUpdateScore(
    UpdateScore event,
    Emitter<LeaderboardState> emit,
  ) async {
    try {
      await userRepository.updateUserScore(
          userId: event.userId, updates: event.updates);
      add(LoadLeaderboard()); // Reload leaderboard after updating score
    } catch (e) {
      emit(LeaderboardError('Failed to update score'));
    }
  }
}
