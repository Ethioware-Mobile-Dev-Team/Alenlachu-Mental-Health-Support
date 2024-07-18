import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/data/common/services/awareness_services.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwarenessBloc extends Bloc<AwarenessEvent, AwarenessState> {
  final AwarenessService awarenessService;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
      String imageName = event.awareness.id!;
      if (event.awareness.image != null) {
        showToast('Deleting old file...');
        final storageRef =
            _storage.ref().child('awareness_images/$imageName.jpg');
        await storageRef.delete();
      }
      showToast('uploading image...');
      final ref = _storage.ref().child('awareness_images/$imageName.jpg');

      UploadTask uploadTask = ref.putData(event.imageBytes);

      await uploadTask.whenComplete(() => null);

      String imageUrl = await ref.getDownloadURL();
      // showToast('ImageUrl: $imageUrl');
      event.awareness.image = imageUrl;
      add(UpdateAwareness(event.awareness));
      add(LoadAwareness());
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
      showToast('Updating......');
      final updatedAwareness =
          await awarenessService.updateAwareness(event.awareness);
      emit(AwarenessOperationSuccess(updatedAwareness));
      add(LoadAwareness());
    } catch (e) {
      emit(AwarenessOperationFailure(e.toString()));
      add(LoadAwareness());
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
