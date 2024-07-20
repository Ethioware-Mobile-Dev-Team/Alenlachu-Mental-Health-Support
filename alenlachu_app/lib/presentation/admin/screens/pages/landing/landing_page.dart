import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/home.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/post.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/profile.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: const AdminAppBar(),
      body: BlocBuilder<AdminBottomNavigationCubit, AdminBottomNavigationState>(
        builder: (context, state) {
          switch (state) {
            case AdminBottomNavigationState.home:
              return const AdminHomePage();
            case AdminBottomNavigationState.post:
              return const AdminPostPage();
            case AdminBottomNavigationState.profile:
              return const AdminProfilePage();
            default:
              return const AdminHomePage();
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<AdminBottomNavigationCubit, AdminBottomNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: AdminBottomNavigationState.values.indexOf(state),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              context
                  .read<AdminBottomNavigationCubit>()
                  .selectItem(AdminBottomNavigationState.values[index]);
            },
          );
        },
      ),
    );
  }
}
