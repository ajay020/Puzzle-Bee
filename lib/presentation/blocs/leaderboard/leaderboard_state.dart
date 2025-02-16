import '../../../domain/entites/user_entity.dart';

abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<User> users;

  LeaderboardLoaded(this.users);
}

class LeaderboardError extends LeaderboardState {
  final String message;

  LeaderboardError(this.message);
}
