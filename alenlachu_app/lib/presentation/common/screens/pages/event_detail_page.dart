import 'package:flutter/material.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: event.image == null
                              ? const AssetImage(
                                  'assets/images/event_default.png',
                                )
                              : NetworkImage(event.image!),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Center(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Date: ${event.date}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Time: ${event.time}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Organizer: ${event.organizer.name}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Location: ${event.organizer.location}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 40),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 40),
                  Text(
                    "RSVPs (${event.rsvps.length})",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...event.rsvps.map((rsvp) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(rsvp),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
