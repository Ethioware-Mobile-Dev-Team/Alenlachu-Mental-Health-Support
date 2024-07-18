import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class JournalModel extends Equatable {
  String id;
  String title;
  String description;
  String deadline;
  String createdDate;
  bool isCompleted;

  JournalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.createdDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'createdDate': createdDate,
      'isCompleted': isCompleted,
    };
  }

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      createdDate: json['createdDate'],
      isCompleted: json['isCompleted'],
    );
  }

  @override
  List<Object?> get props =>
      [title, description, deadline, createdDate, isCompleted];
}
