import 'dart:typed_data';

import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdminEventCard extends StatefulWidget {
  final EventModel event;

  const AdminEventCard({super.key, required this.event});

  @override
  _AdminEventCardState createState() => _AdminEventCardState();
}

class _AdminEventCardState extends State<AdminEventCard> {
  final ImagePicker _picker = ImagePicker();

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      // ignore: use_build_context_synchronously
      BlocProvider.of<EventBloc>(context)
          .add(UpdateEventImage(event: widget.event, imageBytes: imageBytes));
    }
  }

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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 90,
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
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
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
                        lable: _formatDate(DateTime.parse(widget.event.date)),
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
                          const Icon(
                            Icons.location_on,
                            size: 15,
                            color: Colors.blue,
                          ),
                          StyledText(
                            lable: widget.event.organizer.location,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      )),
                  Text('RSVPS: ${widget.event.rsvps.length}'),
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
