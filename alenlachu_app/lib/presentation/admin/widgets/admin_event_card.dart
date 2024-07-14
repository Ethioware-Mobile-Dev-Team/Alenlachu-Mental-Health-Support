import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEventCard extends StatefulWidget {
  final EventModel event;

  const AdminEventCard({super.key, required this.event});

  @override
  _AdminEventCardState createState() => _AdminEventCardState();
}

class _AdminEventCardState extends State<AdminEventCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
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
          child: Row(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: widget.event.image == null
                            ? const AssetImage(
                                'assets/images/event_default.png')
                            : NetworkImage(widget.event.image!),
                        fit: BoxFit.fill)),
              ),
              Column(
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
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
