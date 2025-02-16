import '../../domain/entites/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_remote_datasource.dart';
import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<User>> getLeaderboard() async {
    try {
      final userModels = await _remoteDataSource.getLeaderboard();
      return userModels
          .map((model) => User(
                userId: model.userId,
                username: model.username,
                totalScore: model.totalScore,
                multipleChoiceScore: model.multipleChoiceScore,
                matchingPairsScore: model.matchingPairsScore,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get leaderboard');
    }
  }

  @override
  Future<void> updateUserScore(User user) async {
    try {
      final model = UserModel(
        userId: user.userId,
        username: user.username,
        totalScore: user.totalScore,
        multipleChoiceScore: user.multipleChoiceScore,
        matchingPairsScore: user.matchingPairsScore,
      );
      await _remoteDataSource.updateUserScore(model);
    } catch (e) {
      throw Exception('Failed to update user score');
    }
  }
}
