import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final AuthServices _authServices = AuthServices();
  bool _isRSVP = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _checkRSVPStatus();
  }

  Future<void> _checkRSVPStatus() async {
    _userId = await _authServices.getCurrentUserId();
    if (_userId != null && widget.event.rsvps.contains(_userId)) {
      setState(() {
        _isRSVP = true;
      });
    }
  }

  Future<void> _toggleRSVP() async {
    if (_userId == null) {
      showToast("Failed to fetch user ID");
      return;
    }

    if (_isRSVP) {
      context.read<EventBloc>().add(UnRSVPEvent(widget.event.id!, _userId!));
      // showToast("Un-RSVP successful");
    } else {
      context.read<EventBloc>().add(RSVPEvent(widget.event.id!, _userId!));
      // showToast("RSVP successful");
    }

    setState(() {
      _isRSVP = !_isRSVP;
    });
  }

  String formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 2)
                ],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            image: DecorationImage(
                                image: widget.event.image == null
                                    ? const AssetImage(
                                        'assets/images/event_default.png',
                                      )
                                    : NetworkImage(widget.event.image!),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 30,
                        child: GestureDetector(
                          onTap: () async {
                            await widget.event.organizer.openMaps();
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Center(
                              child: Icon(Icons.location_on),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          lable: widget.event.title,
                          size: 24,
                          color: Colors.black,
                        ),
                        Row(
                          //
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                StyledText(
                                  lable: "Date:",
                                  size: 16,
                                  isBold: false,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            StyledText(
                              lable:
                                  formatDate(DateTime.parse(widget.event.date)),
                              size: 16,
                              isBold: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                StyledText(
                                  lable: "Time:",
                                  size: 16,
                                  isBold: false,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            StyledText(
                              lable: widget.event.time,
                              size: 16,
                              isBold: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                StyledText(
                                  lable: "Organizer:",
                                  size: 16,
                                  isBold: false,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            StyledText(
                              lable: widget.event.organizer.name,
                              size: 16,
                              isBold: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                StyledText(
                                  lable: "Location:",
                                  size: 16,
                                  isBold: false,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            StyledText(
                              lable: widget.event.organizer.location,
                              size: 16,
                              isBold: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 2)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StyledText(
                    lable: 'Description',
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StyledText(
                    lable: widget.event.description,
                    color: Colors.grey,
                    size: 16,
                    isBold: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  StyledText(
                    lable:
                        "${widget.event.rsvps.length}+ peoples had Joined this event so far",
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        return MainButton(
                          onPressed: _toggleRSVP,
                          child:
                              state is EventRSVPing || state is EventUnRSVPing
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : StyledText(
                                      lable: _isRSVP ? 'UnRSVP' : 'RSVP',
                                    ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
