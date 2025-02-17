import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_event.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Puzzle App',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text('Sign in with Google'),
                    onPressed: () {
                      context.read<AuthBloc>().add(SignInWithGooglePressed());
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
