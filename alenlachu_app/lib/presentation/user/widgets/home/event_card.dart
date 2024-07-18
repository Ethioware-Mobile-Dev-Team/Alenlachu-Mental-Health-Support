import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/screens/pages/event_detail_page.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
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
      showToast("Un-RSVP successful");
    } else {
      context.read<EventBloc>().add(RSVPEvent(widget.event.id!, _userId!));
      showToast("RSVP successful");
    }

    setState(() {
      _isRSVP = !_isRSVP;
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventDetailPage(event: widget.event)));
          },
          child: Container(
            height: 210,
            width: 200,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 200, 200, 200),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: widget.event.image == null
                              ? const AssetImage(
                                  'assets/images/event_default.png')
                              : NetworkImage(widget.event.image!),
                          fit: BoxFit.fill)),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          lable: widget.event.title,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timelapse,
                              color: Colors.grey,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            StyledText(
                              lable: _formatDate(
                                  DateTime.parse(widget.event.date)),
                              size: 16,
                              color: Colors.grey,
                              isBold: false,
                              // style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () async {
                              try {
                                await widget.event.organizer.openMaps();
                              } catch (e) {
                                showToast(e.toString());
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                  color: Theme.of(context).primaryColor,
                                ),
                                StyledText(
                                  lable: widget.event.organizer.location,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        MainButton(
                          onPressed: _toggleRSVP,
                          height: 30,
                          width: 80,
                          child: StyledText(
                            lable: _isRSVP ? 'UnRSVP' : 'RSVP',
                            size: 14,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
