import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/login.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApp extends StatefulWidget {
  final UserModel? admin;
  const AdminApp({super.key, required this.admin});

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  void initState() {
    super.initState();
    if (widget.admin != null) {
      context.read<AuthenticationBloc>().add(LoginRequested(
          email: widget.admin!.email, password: widget.admin!.password));
    } else {
      context.read<AuthenticationBloc>().add(AppStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AdminBottomNavigationCubit())
        ],
        child: MaterialApp(
          title: 'Alenlachu Admin App',
          theme: appTheme,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticated) {
              return const AdminLandingPage();
            } else {
              return const LoginPage();
            }
          }),
        ));
  }
}
