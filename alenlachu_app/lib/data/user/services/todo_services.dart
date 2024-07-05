import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoService {
  final AuthServices _authServices = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new todo for a specific user
  Future<void> addTodo(TodoModel todo) async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentReference userDoc = _firestore.collection('todos').doc(user!.uid);
      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        // If the user document exists, update the todos array
        await userDoc.update({
          'todos': FieldValue.arrayUnion([todo.toJson()])
        });
      } else {
        // If the user document does not exist, create it with the first todo
        await userDoc.set({
          'todos': [todo.toJson()]
        });
      }
    } catch (e) {
      showToast("Error adding todo: $e");
    }
  }

  // Fetch all todos for a specific user
  Future<List<TodoModel>> fetchTodos() async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentSnapshot userSnapshot =
          await _firestore.collection('todos').doc(user!.uid).get();
      if (userSnapshot.exists) {
        List<dynamic> todosData = userSnapshot.get('todos');
        return todosData
            .map((todoData) =>
                TodoModel.fromJson(todoData as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      showToast("Error fetching todos: $e");
      return [];
    }
  }

  // Update the entire list of todos for a specific user
  Future<void> updateTodos(List<TodoModel> updatedTodos) async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentReference userDoc = _firestore.collection('todos').doc(user!.uid);
      List<Map<String, dynamic>> updatedTodosData =
          updatedTodos.map((todo) => todo.toJson()).toList();
      await userDoc.update({'todos': updatedTodosData});
    } catch (e) {
      showToast("Error updating todos: $e");
    }
  }
}
