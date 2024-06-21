import 'package:alenlachu_admin_app/blocs/authentication_bloc/auth_bloc.dart';
import 'package:alenlachu_admin_app/blocs/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:alenlachu_admin_app/data/services/authentication/auth_services.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/home_screen.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/post_screen.dart';
import 'package:alenlachu_admin_app/presentation/screens/bottom_navigations/profile_screen.dart';
import 'package:alenlachu_admin_app/presentation/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_admin_app/presentation/widgets/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthServices()),
        ),
        BlocProvider(create: (context) => BottomNavigationCubit())
      ],
      child: MaterialApp(
        title: 'Alenlachu Admin App',
        theme: appTheme,
        home: const LandingPage(),
        routes: {
          '/': (context) => const HomeScreen(),
          '/post': (context) => const PostScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
