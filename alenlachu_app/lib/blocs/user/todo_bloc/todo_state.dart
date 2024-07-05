import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoModel> todos;

  const TodosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodosError extends TodoState {
  final String message;
  const TodosError(this.message);

  @override
  List<Object> get props => [message];
}
