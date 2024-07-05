import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
