import 'package:alenlachu_app/blocs/user/Journal_bloc/Journal_event.dart';
import 'package:alenlachu_app/blocs/user/Journal_bloc/Journal_state.dart';

import 'package:alenlachu_app/data/user/models/Journal_model.dart';

import 'package:alenlachu_app/data/user/services/Journal_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalService _service;
  JournalBloc(this._service) : super(JournalLoading()) {
    on<LoadJournals>(_onLoadJournal);
    on<AddJournal>(_onAddJournal);
    on<RemoveJournal>(_onRemoveJournal);
    on<EditJournal>(_onEditJournal);
  }

  void _onLoadJournal(LoadJournals event, Emitter<JournalState> emit) async {
    emit(JournalLoading());
    try {
      final List<JournalModel> journals = await _service.fetchJournals();
      emit(JournalsLoaded(journals));
    } catch (e) {
      emit(JournalsError(e.toString()));
    }
  }

  void _onAddJournal(AddJournal event, Emitter<JournalState> emit) async {
    emit(JournalLoading());
    try {
      // Generate a unique ID for the new Journal
      String journalId =
          FirebaseFirestore.instance.collection('journals').doc().id;

      JournalModel journal = JournalModel(
          id: journalId,
          title: event.title,
          description: event.description,
          deadline: event.deadline.toString(),
          createdDate: DateTime.now().toString());
      await _service.addJournal(journal);
      emit(JournalsLoaded(await _service.fetchJournals()));
    } catch (e) {
      emit(JournalsError(e.toString()));
    }
  }

  void _onRemoveJournal(RemoveJournal event, Emitter<JournalState> emit) async {
    //emit(JournalLoading());
    if (state is JournalsLoaded) {
      final List<JournalModel> updatedJournals = (state as JournalsLoaded)
          .journals
          .where((journal) => journal.id != event.journal.id)
          .toList();

      try {
        await _service.updateJournals(updatedJournals);
        emit(JournalsLoaded(await _service.fetchJournals()));
      } catch (e) {
        emit(JournalsError('Failed to remove Journal: $e'));
      }
    }
  }

  void _onEditJournal(EditJournal event, Emitter<JournalState> emit) async {
    if (state is JournalsLoaded) {
      final List<JournalModel> updatedJournals =
          (state as JournalsLoaded).journals.map((journal) {
        return journal.id == event.journal.id ? event.journal : journal;
      }).toList();

      try {
        await _service.updateJournals(updatedJournals);
        emit(JournalsLoaded(await _service.fetchJournals()));
      } catch (e) {
        emit(JournalsError('Failed to edit Journal: $e'));
      }
    }
  }
}
