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
            height: 65,
            animationDuration: const Duration(milliseconds: 200),
            animationCurve: Curves.decelerate,
            index: BottomNavigationState.values.indexOf(state),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            items: <Widget>[
              Padding(
                padding: state != BottomNavigationState.home
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.white,
                    ),
                    Visibility(
                        visible: state != BottomNavigationState.home,
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: state != BottomNavigationState.post
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Visibility(
                      visible: state != BottomNavigationState.post,
                      child: Text(
                        'Post',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: state != BottomNavigationState.profile
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Visibility(
                      visible: state != BottomNavigationState.profile,
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    )
                  ],
                ),
              ),
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
