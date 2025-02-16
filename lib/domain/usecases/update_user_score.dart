import '../entites/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateUserScore {
  final UserRepository repository;

  UpdateUserScore(this.repository);

  Future<void> call(User user) async {
    await repository.updateUserScore(user);
  }
}
