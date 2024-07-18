import 'dart:convert';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:http/http.dart' as http;
import 'package:alenlachu_app/data/common/models/event/event_model.dart';

class EventService {
  late final String? _baseUrl = 'https://alenlachuapp-server.onrender.com/api';

  EventService();

  Future<List<EventModel>> getEvents() async {
    final response = await http.get(Uri.parse('$_baseUrl/events'));

    if (response.statusCode == 200) {
      Iterable eventJson = json.decode(response.body);
      return eventJson.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<EventModel> getEventById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/events/$id'));

    if (response.statusCode == 200) {
      return EventModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load event');
    }
  }

  Future<EventModel?> createEvent(EventModel event) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/events'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(event.toJson()),
    );

    if (response.statusCode == 201) {
      showToast("Event Created successfully");
      // showToast(response.body);
      return EventModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create event ${response.request}');
    }
  }

  Future<EventModel> updateEvent(EventModel event) async {
    // showToast(event.id!);
    final response = await http.put(
      Uri.parse('$_baseUrl/events/${event.id!}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(event.toJson()),
    );

    if (response.statusCode == 200) {
      return EventModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/events/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }

  Future<EventModel> rsvpEvent(String eventId, String userId) async {
    // showToast(eventId);
    final response = await http.post(
      Uri.parse('$_baseUrl/events/$eventId/rsvp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      showToast("Event successfully");
      return EventModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to RSVP to event ${response.request}');
    }
  }

  Future<EventModel> unRsvpEvent(String eventId, String userId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/events/$eventId/unrsvp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      return EventModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to un-RSVP to event');
    }
  }
}
