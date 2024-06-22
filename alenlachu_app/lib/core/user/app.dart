import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_theme.dart';
import 'package:alenlachu_app/presentation/user/screens/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserBottomNavigationCubit())
        ],
        child: MaterialApp(
          title: 'Alenlachu User App',
          theme: appTheme,
          routes: {
            '/': (context) => const UserLandingPage(),
          },
        ));
  }
}
