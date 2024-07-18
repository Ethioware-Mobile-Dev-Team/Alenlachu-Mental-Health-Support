import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/chat.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/discover.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/home.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/profile.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/journal.dart';
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
      appBar: const CustomAppBar(),
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
        },
      ),
      bottomNavigationBar:
          BlocBuilder<UserBottomNavigationCubit, UserBottomNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: UserBottomNavigationState.values.indexOf(state),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_rounded),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
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
