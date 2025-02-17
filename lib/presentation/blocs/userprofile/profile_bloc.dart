import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/userprofile/profile_event.dart';
import 'package:puzzle_bee/presentation/blocs/userprofile/profile_state.dart';

import '../../../domain/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await userRepository.fetchUserProfile(event.userId);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError('Failed to fetch profile'));
    }
  }
}
