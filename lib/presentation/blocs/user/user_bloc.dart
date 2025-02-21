import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/user/user_event.dart';
import 'package:puzzle_bee/presentation/blocs/user/user_state.dart';

import '../../../domain/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, ProfileState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<FetchUser>(_onFetchProfile);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onFetchProfile(
    FetchUser event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await userRepository.getUser(event.userId);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError('Failed to fetch profile'));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await userRepository.updateUser(event.userModel);
    } catch (e) {
      emit(ProfileError('Failed to update user profile'));
    }
  }
}
