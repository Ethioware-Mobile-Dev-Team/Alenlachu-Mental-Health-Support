import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/presentation/common/widgets/quote_carousel.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:alenlachu_app/presentation/user/widgets/home/awareness_card.dart';
import 'package:alenlachu_app/presentation/user/widgets/home/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  Future<void> _onRefresh() async {
    BlocProvider.of<EventBloc>(context).add(LoadEvents());
    BlocProvider.of<AwarenessBloc>(context).add(LoadAwareness());

    // Simulate a network request
    // await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: SizedBox(
          child: BlocListener<EventBloc, EventState>(
            listener: (context, state) {
              if (state is EventRSVPing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Event RSVPing. . ."),
                    duration: Duration(seconds: 1),
                  ),
                );
              }

              if (state is EventUnRSVPing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Event UnRSVPing. . ."),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageCarousel(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StyledText(
                        lable: "Explore Events",
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: BlocBuilder<EventBloc, EventState>(
                            builder: (context, state) {
                              if (state is EventLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is EventLoaded) {
                                if (state.events.isEmpty) {
                                  return const Center(
                                      child: StyledText(
                                    lable: 'Events will apear here.',
                                    color: Colors.grey,
                                    size: 14,
                                  ));
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.events.length,
                                    itemBuilder: (context, index) {
                                      final event = state.events[index];
                                      return EventCard(event: event);
                                    },
                                  );
                                }
                              } else if (state is EventOperationFailure) {
                                return Center(
                                  child: Text(
                                      'Unknown error occurred ${state.error}'),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const StyledText(
                        lable: "Did You Know That?",
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: BlocBuilder<AwarenessBloc, AwarenessState>(
                            builder: (context, state) {
                              if (state is AwarenessLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is AwarenessLoaded) {
                                if (state.awarenesss.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'Awarenesses will appear here.'));
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.awarenesss.length,
                                    itemBuilder: (context, index) {
                                      final awareness = state.awarenesss[index];
                                      return AwarenessCard(
                                        awareness: awareness,
                                      );
                                    },
                                  );
                                }
                              } else if (state is AwarenessOperationFailure) {
                                return Center(
                                  child: Text(
                                      'Unknown error occurred ${state.error}'),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
