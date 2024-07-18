import 'package:alenlachu_app/data/user/models/Journal_model.dart';
import 'package:equatable/equatable.dart';

abstract class JournalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddJournal extends JournalEvent {
  final String title;
  final String description;
  final DateTime deadline;

  AddJournal({
    required this.title,
    required this.description,
    required this.deadline,
  });

  @override
  List<Object> get props => [title, description, deadline];
}

class RemoveJournal extends JournalEvent {
  final JournalModel journal;
  RemoveJournal({
    required this.journal,
  });

  @override
  List<Object> get props => [journal];
}

class EditJournal extends JournalEvent {
  final JournalModel journal;
  EditJournal({
    required this.journal,
  });

  @override
  List<Object> get props => [journal];
}

class LoadJournals extends JournalEvent {}
