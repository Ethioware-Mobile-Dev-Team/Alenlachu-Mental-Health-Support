import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 240,
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
                height: 120,
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
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.event.date,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(widget.event.organizer.location),
                    TextButton(
                        onPressed: _toggleRSVP,
                        child: Text(
                          _isRSVP ? 'Un-RSVP' : 'RSVP',
                          style: const TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
