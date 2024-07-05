import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final DateTime createdDate;
  final DateTime deadline;

  AddTodo({
    required this.title,
    required this.description,
    required this.createdDate,
    required this.deadline,
  });

  @override
  List<Object> get props => [title, description, createdDate, deadline];
}

class RemoveTodo extends TodoEvent {
  final TodoModel todo;
  RemoveTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class EditTodo extends TodoEvent {
  final TodoModel todo;
  EditTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class LoadTodos extends TodoEvent {}
