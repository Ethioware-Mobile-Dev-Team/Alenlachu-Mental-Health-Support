import 'dart:async';

import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';

class UserCountCard extends StatelessWidget {
  const UserCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices authServices = AuthServices();

    return Container(
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: FutureBuilder<int>(
          future: authServices.getTotalUserCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )); // Display a loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: Text(
                  '${snapshot.data}+\nUsers',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
