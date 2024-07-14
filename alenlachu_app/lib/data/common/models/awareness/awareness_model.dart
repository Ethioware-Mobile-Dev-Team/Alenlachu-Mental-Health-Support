import 'package:equatable/equatable.dart';

class AwarenessModel extends Equatable {
  final String? id;
  final String title;
  final String description;
  final DateTime createdDate;
  String? image;

  AwarenessModel({
    this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    this.image,
  });

  @override
  List<Object?> get props => [id, title, description, createdDate, image];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'createdDate':
          createdDate.toIso8601String(), // Convert DateTime to ISO8601 string
      'image': image,
    };
  }

  factory AwarenessModel.fromJson(Map<String, dynamic> json) {
    return AwarenessModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      createdDate: DateTime.parse(
          json['createdDate']), // Parse ISO8601 string to DateTime
      image: json['image'],
    );
  }
}
