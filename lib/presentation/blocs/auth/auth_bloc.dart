import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/data/models/user/user_model.dart';
import 'package:puzzle_bee/domain/repositories/user_repository.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_event.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_state.dart';

import '../../../data/models/user/user_auth_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  StreamSubscription<UserAuthModel?>? _authSubscription;

  AuthBloc({required this.authRepository, required this.userRepository})
      : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignInWithGooglePressed>(_onSignInWithGooglePressed);
    on<SignOutPressed>(_onSignOutPressed);
    on<AuthStateChanged>(_onAuthStateChanged);

    // Listen to authentication state changes
    _authSubscription = authRepository.authStateChanges.listen((user) {
      add(AuthStateChanged(user));
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = authRepository.currentUser;
    if (user != null) {
      final userData = await userRepository.fetchUserProfile(user.uid);
      emit(Authenticated(user, userData!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInWithGooglePressed(
    SignInWithGooglePressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      if (user != null) {
        final userData = UserModel(
          userId: user.uid,
          username: user.displayName,
        );
        // Emit the authenticated state
        emit(Authenticated(user, userData));
      } else {
        // Emit the unauthenticated state if no user is returned
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutPressed(
    SignOutPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      // Emit the unauthenticated state after signing out
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      final userData = UserModel(
        userId: event.user!.uid,
        username: event.user!.displayName,
      );
      emit(Authenticated(event.user!, userData));
    } else {
      emit(Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    // Cancel the subscription when the bloc is closed
    _authSubscription?.cancel();
    return super.close();
  }
}
