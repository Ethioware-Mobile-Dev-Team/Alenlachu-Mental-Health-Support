import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBottomNavigationCubit, AdminBottomNavigationState>(
      builder: (context, state) {
        String title = '';

        // Set title based on current navigation state
        switch (state) {
          case AdminBottomNavigationState.home:
            title = 'Home';
            break;
          case AdminBottomNavigationState.post:
            title = 'Post';
            break;
          case AdminBottomNavigationState.profile:
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
