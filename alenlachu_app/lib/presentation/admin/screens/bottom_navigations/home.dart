import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/admin/widgets/total_awareness_card.dart';
import 'package:alenlachu_app/presentation/admin/widgets/total_events_card.dart';
import 'package:alenlachu_app/presentation/admin/widgets/total_users_card.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserCountCard(),
              EventCountCard(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AwarenessCountCard(),
        ],
      ),
    ));
  }
}

class AuthneticationState {}
