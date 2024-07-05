import 'package:alenlachu_app/blocs/user/todo_bloc/todo_bloc.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_event.dart';
import 'package:alenlachu_app/blocs/user/todo_bloc/todo_state.dart';
import 'package:alenlachu_app/data/user/models/todo_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/user/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPlannerPage extends StatefulWidget {
  const TodoPlannerPage({super.key});

  @override
  State<TodoPlannerPage> createState() => _TodoPlannerPageState();
}

class _TodoPlannerPageState extends State<TodoPlannerPage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'ToDo',
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No todos found.'));
            } else {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return TodoCard(
                    todo: state.todos[index],
                  );
                },
              );
            }
          } else if (state is TodosError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/createTodoPage');
        },
        tooltip: 'Create Todo',
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
