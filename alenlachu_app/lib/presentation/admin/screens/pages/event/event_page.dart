import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EventLoaded) {
                if (state.events.isEmpty) {
                  return const Center(
                    child: Text('No events found'),
                  );
                }
                return ListView.builder(
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    final event = state.events[index];
                    return AdminEventCard(event: event);
                  },
                );
              } else if (state is EventOperationFailure) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: Text('Unknown error occurred'),
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/createEventPage');
            },
            backgroundColor: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
            tooltip: 'Create Event',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
