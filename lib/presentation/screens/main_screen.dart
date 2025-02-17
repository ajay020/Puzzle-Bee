import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_bloc.dart';
import 'package:puzzle_bee/presentation/blocs/auth/auth_state.dart';
import 'package:puzzle_bee/presentation/screens/leader_board_screen.dart';

import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final userId = state.authUser.uid;

          final List<Widget> screens = [
            HomeScreen(),
            LeaderboardScreen(),
            ProfileScreen(userId: userId),
          ];

          return Scaffold(
            body: screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: "Leaderboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          );
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
