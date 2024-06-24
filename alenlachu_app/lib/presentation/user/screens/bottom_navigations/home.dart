import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';

import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Text('Welcome ${state.user!.name} To User HomePage');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
