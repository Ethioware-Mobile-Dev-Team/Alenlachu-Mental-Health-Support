import 'package:alenlachu_app/data/user/models/journal_model.dart';
import 'package:equatable/equatable.dart';

abstract class JournalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddJournal extends JournalEvent {
  final String title;
  final String description;

  AddJournal({
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [title, description];
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
