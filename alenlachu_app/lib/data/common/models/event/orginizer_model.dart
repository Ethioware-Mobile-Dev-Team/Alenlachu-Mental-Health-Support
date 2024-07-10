import 'package:equatable/equatable.dart';

class Organizer extends Equatable {
  final String name;
  final String location;

  const Organizer({required this.name, required this.location});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
    };
  }

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      name: json['name'],
      location: json['location'],
    );
  }

  @override
  List<Object?> get props => [name, location];
}
