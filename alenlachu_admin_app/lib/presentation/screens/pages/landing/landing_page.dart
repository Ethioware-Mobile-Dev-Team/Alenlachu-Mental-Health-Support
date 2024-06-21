import 'package:alenlachu_admin_app/blocs/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/home_screen.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/post_screen.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
        switch (state) {
          case BottomNavigationState.home:
            return const HomeScreen();
          case BottomNavigationState.post:
            return const PostScreen();
          case BottomNavigationState.profile:
            return const ProfileScreen();
          default:
            return const HomeScreen();
        }
      }),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            index: BottomNavigationState.values.indexOf(state),
            backgroundColor: Colors.blueAccent,
            items: const <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.add, size: 30),
              Icon(Icons.person, size: 30),
            ],
            onTap: (index) {
              context
                  .read<BottomNavigationCubit>()
                  .selectItem(BottomNavigationState.values[index]);
            },
          );
        },
      ),
    );
  }
}
