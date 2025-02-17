import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_state.dart';
import 'package:puzzle_bee/presentation/screens/login_screen.dart';
import 'package:puzzle_bee/presentation/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PuzzleBee",
        debugShowCheckedModeBanner: false,
        home: AuthWrapper());
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthLoading) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (state is Authenticated) {
        return MainScreen();
      }

      return LoginScreen();
    });
  }
}
