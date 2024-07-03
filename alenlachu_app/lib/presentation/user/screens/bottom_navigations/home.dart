import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';

import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:alenlachu_app/presentation/common/widgets/quote_carousel.dart';
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
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ImageCarousel(),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return Text('Welcome ${state.user!.name} To User HomePage');
              }

              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
