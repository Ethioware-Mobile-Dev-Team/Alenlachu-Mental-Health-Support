import 'package:alenlachu_app/blocs/user/journal_bloc/journal_bloc.dart';
import 'package:alenlachu_app/blocs/user/journal_bloc/journal_event.dart';
import 'package:alenlachu_app/blocs/user/journal_bloc/journal_state.dart';
import 'package:alenlachu_app/presentation/user/widgets/journal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPlannerPage extends StatefulWidget {
  const TodoPlannerPage({super.key});

  @override
  State<TodoPlannerPage> createState() => _TodoPlannerPageState();
}

class _TodoPlannerPageState extends State<TodoPlannerPage> {
  Future<void> _onRefresh() async {
    BlocProvider.of<JournalBloc>(context).add(LoadJournals());
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<JournalBloc>(context).add(LoadJournals());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<JournalBloc, JournalState>(
              builder: (context, state) {
                if (state is JournalLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JournalsLoaded) {
                  if (state.journals.isEmpty) {
                    return const Center(child: Text('No todos found.'));
                  } else {
                    return ListView.builder(
                      itemCount: state.journals.length,
                      itemBuilder: (context, index) {
                        return JournalCard(
                          journal: state.journals[index],
                        );
                      },
                    );
                  }
                } else if (state is JournalsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Something went wrong.'));
                }
              },
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/createTodoPage');
              },
              tooltip: 'Create Todo',
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 10,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
