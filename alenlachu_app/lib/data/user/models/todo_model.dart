import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  String id;
  String title;
  String description;
  DateTime deadline;
  DateTime createdDate;
  bool isCompleted;

  TodoModel({
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

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'] as DateTime,
      createdDate: json['createdDate'] as DateTime,
      isCompleted: json['isCompleted'],
    );
  }

  @override
  List<Object?> get props =>
      [title, description, deadline, createdDate, isCompleted];
}
