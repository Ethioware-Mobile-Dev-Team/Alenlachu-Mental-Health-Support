import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/chat.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/discover.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/home.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/profile.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/todo.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLandingPage extends StatefulWidget {
  const UserLandingPage({super.key});

  @override
  State<UserLandingPage> createState() => _UserLandingPageState();
}

class _UserLandingPageState extends State<UserLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBottomNavigationCubit, UserBottomNavigationState>(
          builder: (context, state) {
        switch (state) {
          case UserBottomNavigationState.home:
            return const UserHomePage();
          case UserBottomNavigationState.todo:
            return const TodoPlannerPage();
          case UserBottomNavigationState.discover:
            return const DiscoverPage();
          case UserBottomNavigationState.chat:
            return const ChatPage();
          case UserBottomNavigationState.profile:
            return const UserProfilePage();
          default:
            return const UserHomePage();
        }
      }),
      bottomNavigationBar:
          BlocBuilder<UserBottomNavigationCubit, UserBottomNavigationState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            height: 65,
            animationDuration: const Duration(milliseconds: 200),
            animationCurve: Curves.decelerate,
            index: UserBottomNavigationState.values.indexOf(state),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            items: <Widget>[
              Padding(
                padding: state != UserBottomNavigationState.home
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
                        visible: state != UserBottomNavigationState.home,
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: state != UserBottomNavigationState.todo
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
                      visible: state != UserBottomNavigationState.todo,
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
                padding: state != UserBottomNavigationState.discover
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
                      visible: state != UserBottomNavigationState.discover,
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
                padding: state != UserBottomNavigationState.chat
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
                      visible: state != UserBottomNavigationState.chat,
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
                padding: state != UserBottomNavigationState.profile
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
                      visible: state != UserBottomNavigationState.profile,
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
                  .read<UserBottomNavigationCubit>()
                  .selectItem(UserBottomNavigationState.values[index]);
            },
          );
        },
      ),
    );
  }
}
