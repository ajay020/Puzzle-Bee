import 'package:puzzle_bee/data/models/user/user_model.dart';

abstract class UserEvent {}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser(this.userId);
}

class UpdateUser extends UserEvent {
  final UserModel userModel;

  UpdateUser(this.userModel);
}
