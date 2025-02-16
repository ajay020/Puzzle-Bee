import '../../../domain/entites/user_entity.dart';

abstract class LeaderboardEvent {}

class LoadLeaderboard extends LeaderboardEvent {}

class UpdateScore extends LeaderboardEvent {
  final User user;

  UpdateScore(this.user);
}
