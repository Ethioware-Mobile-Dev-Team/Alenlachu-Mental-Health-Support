import 'package:alenlachu_app/blocs/user/todo_bloc/todo_bloc.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_event.dart';
import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  // final VoidCallback onDelete;

  const TodoCard({
    required this.todo,
    //required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id), // Unique key for each todo card
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // Display confirmation dialog when swiped
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you want to delete this item?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(RemoveTodo(todo: todo));
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },

      // onDismissed: (direction) {
      //   // Delete the todo when dismissed
      //   onDelete();
      // },

      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(todo.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deadline: ${todo.deadline}'),
              Text('Created Date: ${todo.createdDate}'),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, todo);
            },
          ),
          onTap: () {
            _showDetailsDialog(context, todo);
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, TodoModel todo) {
    // Implement edit dialog using TodoBloc
    // Dispatch an EditTodo event to update the todo
  }

  void _showDetailsDialog(BuildContext context, TodoModel todo) {
    // Implement details dialog here
    // Display all details about the todo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(todo.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description: ${todo.description}'),
              Text('Deadline: ${todo.deadline}'),
              Text('Created Date: ${todo.createdDate}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
