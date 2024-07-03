import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';

class TodoPlannerPage extends StatefulWidget {
  const TodoPlannerPage({super.key});

  @override
  State<TodoPlannerPage> createState() => _TodoPlannerPageState();
}

class _TodoPlannerPageState extends State<TodoPlannerPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'ToDo',
      ),
      body: Center(
        child: Text('Todo Planner Page'),
      ),
    );
  }
}
