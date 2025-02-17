import 'package:puzzle_bee/data/models/user/user_model.dart';

abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<UserModel> users;

  LeaderboardLoaded(this.users);
}

class LeaderboardError extends LeaderboardState {
  final String message;

  LeaderboardError(this.message);
}
