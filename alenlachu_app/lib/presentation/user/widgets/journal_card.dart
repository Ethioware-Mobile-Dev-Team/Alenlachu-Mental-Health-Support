import 'package:alenlachu_app/blocs/user/journal_bloc/journal_bloc.dart';
import 'package:alenlachu_app/blocs/user/journal_bloc/journal_event.dart';
import 'package:alenlachu_app/data/user/models/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalCard extends StatelessWidget {
  final JournalModel journal;
  // final VoidCallback onDelete;

  const JournalCard({
    required this.journal,
    //required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(journal.id), // Unique key for each todo card
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
                    context
                        .read<JournalBloc>()
                        .add(RemoveJournal(journal: journal));
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
          title: Text(journal.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deadline: ${journal.deadline}'),
              Text('Created Date: ${journal.createdDate}'),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, journal);
            },
          ),
          onTap: () {
            _showDetailsDialog(context, journal);
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, JournalModel journal) {
    // Implement edit dialog using TodoBloc
    // Dispatch an EditTodo event to update the todo
  }

  void _showDetailsDialog(BuildContext context, JournalModel journal) {
    // Implement details dialog here
    // Display all details about the todo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(journal.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description: ${journal.description}'),
              Text('Deadline: ${journal.deadline}'),
              Text('Created Date: ${journal.createdDate}'),
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
