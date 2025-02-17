abstract class LeaderboardEvent {}

class LoadLeaderboard extends LeaderboardEvent {}

class UpdateScore extends LeaderboardEvent {
  final String userId;
  final Map<String, dynamic> updates;

  UpdateScore({
    required this.userId,
    required this.updates,
  });
}
