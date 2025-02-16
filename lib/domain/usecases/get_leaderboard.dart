import '../entites/user_entity.dart';
import '../repositories/user_repository.dart';

class GetLeaderboard {
  final UserRepository repository;

  GetLeaderboard(this.repository);

  Future<List<User>> call() async {
    return await repository.getLeaderboard();
  }
}
