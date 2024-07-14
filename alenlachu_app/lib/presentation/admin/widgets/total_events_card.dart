import 'dart:async';

import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCountCard extends StatelessWidget {
  const EventCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              return CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: Text(
                  '${state.events.length}+\nEvents',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              );
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}
