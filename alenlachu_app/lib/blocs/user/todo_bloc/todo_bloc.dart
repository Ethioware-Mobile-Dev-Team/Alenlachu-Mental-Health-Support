import 'package:alenlachu_app/blocs/user/todo_bloc/todo_event.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_state.dart';
import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:alenlachu_app/data/user/services/todo_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _service;
  TodoBloc(this._service) : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodo);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<EditTodo>(_onEditTodo);
  }

  void _onLoadTodo(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final List<TodoModel> todos = await _service.fetchTodos();
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      // Generate a unique ID for the new todo
      String todoId = FirebaseFirestore.instance.collection('todos').doc().id;

      TodoModel todo = TodoModel(
          id: todoId,
          title: event.title,
          description: event.description,
          deadline: event.deadline,
          createdDate: DateTime.now());
      await _service.addTodo(todo);
      emit(TodosLoaded(await _service.fetchTodos()));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    if (state is TodosLoaded) {
      final List<TodoModel> updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();

      try {
        await _service.updateTodos(updatedTodos);
        emit(TodosLoaded(await _service.fetchTodos()));
      } catch (e) {
        emit(TodosError('Failed to remove todo: $e'));
      }
    }
  }

  void _onEditTodo(EditTodo event, Emitter<TodoState> emit) async {
    if (state is TodosLoaded) {
      final List<TodoModel> updatedTodos =
          (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      try {
        await _service.updateTodos(updatedTodos);
        emit(TodosLoaded(await _service.fetchTodos()));
      } catch (e) {
        emit(TodosError('Failed to edit todo: $e'));
      }
    }
  }
}
