import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/profile/profile_cubit.dart';
import 'package:alenlachu_app/blocs/user/bottom_navigation_cubit/user_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_bloc.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_event.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/data/common/services/awareness_services.dart';
import 'package:alenlachu_app/data/common/services/event_services.dart';
import 'package:alenlachu_app/data/user/services/todo_services.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/awareness/create_awareness.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/event/create_event.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/login.dart';
import 'package:alenlachu_app/presentation/common/screens/pages/profile_setting.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_theme.dart';
import 'package:alenlachu_app/presentation/user/screens/pages/create_todo-page.dart';
import 'package:alenlachu_app/presentation/user/screens/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatefulWidget {
  final UserModel? user;
  const MainApp({super.key, required this.user});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      context.read<AuthenticationBloc>().add(LoginRequested(
          email: widget.user!.email, password: widget.user!.password));
    } else {
      context.read<AuthenticationBloc>().add(AppStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserBottomNavigationCubit()),
          BlocProvider(
              create: (context) => ProfileCubit(
                  context.read<AuthenticationBloc>().authServices,
                  context.read<AuthenticationBloc>())),
          BlocProvider(create: (context) => AdminBottomNavigationCubit()),
          BlocProvider(
              create: (context) => TodoBloc(TodoService())..add(LoadTodos())),
          BlocProvider(
              create: (context) =>
                  EventBloc(EventService())..add(LoadEvents())),
          BlocProvider(
              create: (context) =>
                  AwarenessBloc(AwarenessService())..add(LoadAwareness())),
        ],
        // AwarenessBloc
        child: MaterialApp(
          title: 'Alenlachu Mental Health Support',
          theme: appTheme,
          routes: {
            '/profile': (context) => const ProfileSetting(),
            '/createTodoPage': (context) => const CreateTodoPage(),
            '/createAwarenessPage': (context) => const AwarenessCreatePage(),
            '/createEventPage': (context) => const CreateEventPage(),
          },
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticated) {
              if (state.user!.role == 'admin') {
                return const AdminLandingPage();
              } else {
                return const UserLandingPage();
              }
            } else {
              return const LoginPage();
            }
          }),
        ));
  }
}
