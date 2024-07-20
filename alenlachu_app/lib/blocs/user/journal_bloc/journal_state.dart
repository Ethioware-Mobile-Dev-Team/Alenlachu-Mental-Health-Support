import 'package:alenlachu_app/data/user/models/journal_model.dart';
import 'package:equatable/equatable.dart';

abstract class JournalState extends Equatable {
  const JournalState();

  @override
  List<Object> get props => [];
}

class JournalLoading extends JournalState {}

class JournalsLoaded extends JournalState {
  final List<JournalModel> journals;

  const JournalsLoaded(this.journals);

  @override
  List<Object> get props => [journals];
}

class JournalsError extends JournalState {
  final String message;
  const JournalsError(this.message);

  @override
  List<Object> get props => [message];
}
