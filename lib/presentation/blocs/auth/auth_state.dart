import 'package:equatable/equatable.dart';
import 'package:puzzle_bee/data/models/user/user_model.dart';

import '../../../data/models/user/user_auth_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserAuthModel authUser;
  final UserModel userData;

  Authenticated(this.authUser, this.userData);

  @override
  List<Object?> get props => [authUser, userData];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
