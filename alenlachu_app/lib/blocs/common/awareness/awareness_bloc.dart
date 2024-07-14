import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/data/common/services/awareness_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';

class AwarenessBloc extends Bloc<AwarenessEvent, AwarenessState> {
  final AwarenessService awarenessService;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  AwarenessBloc(this.awarenessService) : super(AwarenessInitial()) {
    on<LoadAwareness>(_onLoadAwareness);
    on<CreateAwareness>(_onCreateAwareness);
    on<UpdateAwareness>(_onUpdateAwareness);
    on<UpdateAwarenessImage>(_onUpdateAwarenessImage);
    on<DeleteAwareness>(_onDeleteAwareness);
  }
  Future<void> _onUpdateAwarenessImage(
      UpdateAwarenessImage event, Emitter<AwarenessState> emit) async {
    emit(AwarenessLoading());
    try {
      String imageName = event.awareness.id.toString();
      firebase_storage.Reference ref =
          _storage.ref().child('awareness_images/$imageName.jpg');

      firebase_storage.UploadTask uploadTask = ref.putData(event.imageBytes);

      await uploadTask.whenComplete(() => null);

      String imageUrl = await ref.getDownloadURL();
      event.awareness.image = imageUrl;
      add(UpdateAwareness(event.awareness.id, event.awareness));
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> _onLoadAwareness(
      LoadAwareness event, Emitter<AwarenessState> emit) async {
    emit(AwarenessLoading());
    try {
      final awarenessList = await awarenessService.getAwarenessEntries();
      emit(AwarenessLoaded(awarenessList));
    } catch (e) {
      emit(AwarenessOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateAwareness(
      CreateAwareness event, Emitter<AwarenessState> emit) async {
    emit(AwarenessLoading());
    try {
      final newAwareness =
          await awarenessService.createAwareness(event.awareness);
      emit(AwarenessOperationSuccess(newAwareness));
      add(LoadAwareness());
    } catch (e) {
      emit(AwarenessOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateAwareness(
      UpdateAwareness event, Emitter<AwarenessState> emit) async {
    emit(AwarenessLoading());
    try {
      final updatedAwareness =
          await awarenessService.updateAwareness(event.id, event.awareness);
      emit(AwarenessOperationSuccess(updatedAwareness));
      add(LoadAwareness());
    } catch (e) {
      emit(AwarenessOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteAwareness(
      DeleteAwareness event, Emitter<AwarenessState> emit) async {
    emit(AwarenessLoading());
    try {
      await awarenessService.deleteAwareness(event.id);
      final updatedAwarenessList = await awarenessService.getAwarenessEntries();
      emit(AwarenessLoaded(updatedAwarenessList));
    } catch (e) {
      emit(AwarenessOperationFailure(e.toString()));
    }
  }
}
