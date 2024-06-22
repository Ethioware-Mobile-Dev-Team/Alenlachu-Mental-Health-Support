import 'package:alenlachu_app/blocs/admin/bottom_navigation_cubit/admin_bottom_navigation_cubit.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/home.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/post.dart';
import 'package:alenlachu_app/presentation/admin/screens/bottom_navigations/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      }),
      bottomNavigationBar:
          BlocBuilder<AdminBottomNavigationCubit, AdminBottomNavigationState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            height: 65,
            animationDuration: const Duration(milliseconds: 200),
            animationCurve: Curves.decelerate,
            index: AdminBottomNavigationState.values.indexOf(state),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            items: <Widget>[
              Padding(
                padding: state != AdminBottomNavigationState.home
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.white,
                    ),
                    Visibility(
                        visible: state != AdminBottomNavigationState.home,
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: state != AdminBottomNavigationState.post
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Visibility(
                      visible: state != AdminBottomNavigationState.post,
                      child: Text(
                        'Post',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: state != AdminBottomNavigationState.profile
                    ? const EdgeInsets.only(top: 20.0)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Visibility(
                      visible: state != AdminBottomNavigationState.profile,
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    )
                  ],
                ),
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
