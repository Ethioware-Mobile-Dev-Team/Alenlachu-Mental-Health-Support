import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBottomNavigationCubit, UserBottomNavigationState>(
      builder: (context, state) {
        String title = '';

        // Set title based on current navigation state
        switch (state) {
          case UserBottomNavigationState.home:
            title = 'Home';
            break;
          case UserBottomNavigationState.journal:
            title = 'journal';
            break;
          case UserBottomNavigationState.venting:
            title = 'Venting Space';
            break;
          case UserBottomNavigationState.chat:
            title = 'Chat';
            break;
          case UserBottomNavigationState.profile:
            title = 'Profile';
            break;
          default:
            title = '';
        }

        return AppBar(
          centerTitle: true,
          title: title.isNotEmpty
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )
              : null, // Show title if provided, otherwise null
          actions: [
            const Icon(Icons.notifications),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: CircleAvatar(
                      backgroundImage: state.user!.photoUrl == null
                          ? const AssetImage("assets/images/Profile.png")
                          : NetworkImage(state.user!.photoUrl!),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
