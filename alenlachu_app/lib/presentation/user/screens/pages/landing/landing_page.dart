import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/chat.dart';
import 'package:alenlachu_app/presentation/user/screens/bottom_navigations/venting.dart';
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
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<UserBottomNavigationCubit, UserBottomNavigationState>(
        builder: (context, state) {
          switch (state) {
            case UserBottomNavigationState.home:
              return const UserHomePage();
            case UserBottomNavigationState.journal:
              return const JournalPage();
            case UserBottomNavigationState.venting:
              return const VentingPage();
            case UserBottomNavigationState.chat:
              return ChatPage();
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
                icon: Icon(Icons.edit_note),
                label: 'Journal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.spatial_audio_rounded),
                label: 'Venting',
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
