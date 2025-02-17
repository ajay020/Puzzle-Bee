import 'package:equatable/equatable.dart';

import '../../../data/models/user/user_auth_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class SignInWithGooglePressed extends AuthEvent {}

class SignOutPressed extends AuthEvent {}

class AuthStateChanged extends AuthEvent {
  final UserAuthModel? user;
  AuthStateChanged(this.user);
}
