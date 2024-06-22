import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({super.key});

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AdminBottomNavigationCubit())
        ],
        child: MaterialApp(
          title: 'Alenlachu Admin App',
          theme: appTheme,
          routes: {
            '/': (context) => const AdminLandingPage(),
          },
        ));
  }
}
