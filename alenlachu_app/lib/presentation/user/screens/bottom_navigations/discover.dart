import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<EventBloc>().add(LoadEvents());
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event operation successful')),
            );
          } else if (state is EventOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to perform event operation')),
            );
          }
        },
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.description),
                    trailing: Text(event.date),
                    onTap: () async {
                      context.read<EventBloc>().add(DeleteEvent(event.id));
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load events'));
            }
          },
        ),
      ),
    );
  }
}
