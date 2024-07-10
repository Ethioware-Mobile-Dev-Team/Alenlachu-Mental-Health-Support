import 'package:alenlachu_app/data/common/models/event/orginizer_model.dart';
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final Organizer organizer;
  final List<String> rsvps; // List of user IDs who have RSVP'd
  String photo;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.organizer,
    this.rsvps = const [],
    this.photo = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date, // Convert DateTime to ISO 8601 string
      'time': time,
      'organizer': organizer.toJson(),
      'rsvps': rsvps,
      'photo': photo,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: json['date'], // Parse ISO 8601 string to DateTime
      time: json['time'],
      organizer: Organizer.fromJson(json['organizer']),
      rsvps: List<String>.from(json['rsvps']),
      photo: json['photo'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        time,
        organizer,
        rsvps,
        photo,
      ];
}
