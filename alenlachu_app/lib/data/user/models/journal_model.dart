import 'package:equatable/equatable.dart';

class JournalModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdDate;

  const JournalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  @override
  List<Object?> get props => [id, title, description, createdDate];
}
