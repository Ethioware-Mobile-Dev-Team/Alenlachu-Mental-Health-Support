import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: state.user!.photoUrl == null
                      ? const AssetImage("assets/images/Profile.png")
                      : NetworkImage(state.user!.photoUrl!),
                  radius: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.user!.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Profile"),
                        const Spacer(),
                        const Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.color_lens),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Theme"),
                      Spacer(),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.group),
                      SizedBox(
                        width: 10,
                      ),
                      Text("About US"),
                      Spacer(),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      SizedBox(
                        width: 10,
                      ),
                      Text("FAQ"),
                      Spacer(),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthenticationBloc>().add(LoggedOut());
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is Authenticating) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
