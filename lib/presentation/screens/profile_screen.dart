import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_event.dart';

import '../../domain/repositories/user_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/userprofile/profile_bloc.dart';
import '../blocs/userprofile/profile_event.dart';
import '../blocs/userprofile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(userRepository: context.read<UserRepository>())
          ..add(FetchProfile(userId));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(SignOutPressed());
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL ?? ''),
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildScoreCard('Total Score', user.totalScore),
                    _buildScoreCard(
                        'Multiple Choice Score', user.multipleChoiceScore),
                    _buildScoreCard(
                        'Matching Pairs Score', user.matchingPairsScore),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildScoreCard(String label, int score) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              score.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
