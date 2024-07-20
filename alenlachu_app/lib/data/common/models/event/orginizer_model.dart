import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String get mapsUrl {
    final query = Uri.encodeComponent(location);
    return 'https://www.google.com/maps/search/?api=1&query=$query';
  }

  Future<void> openMaps() async {
    final url = Uri.parse(mapsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  List<Object?> get props => [name, location];
}
