import 'package:alenlachu_app/blocs/user/journal_bloc/journal_bloc.dart';
import 'package:alenlachu_app/blocs/user/journal_bloc/journal_event.dart';
import 'package:alenlachu_app/data/user/models/journal_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          title: Text(
            journal.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                journal.description,
                maxLines: 4,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(
                'Created Date: ${_formatDate(journal.createdDate)}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you want to delete this item?"),
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
          ),
          onTap: () {
            _showDetailsDialog(context, journal);
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
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
              Text('Created Date: ${_formatDate(journal.createdDate)}'),
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
