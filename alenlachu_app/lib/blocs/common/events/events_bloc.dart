import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/services/event_services.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventService eventService;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  EventBloc(this.eventService) : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<CreateEvent>(_onCreateEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<UpdateEventImage>(_onUpdateEventImage);
    on<RSVPEvent>(_onRSVPEvent);
    on<UnRSVPEvent>(_onUnRSVPEvent);
  }

  Future<void> _onUpdateEventImage(
      UpdateEventImage event, Emitter<EventState> emit) async {
    emit(EventLoading());

    try {
      String imageName = event.event.id!;
      // showToast(imageName);
      if (event.event.image != null) {
        showToast('Deleting old file...');
        final storageRef = _storage.ref().child('event_images/$imageName.jpg');
        await storageRef.delete();
      }
      showToast('uploading image...');
      final ref = _storage.ref().child('event_images/$imageName.jpg');

      UploadTask uploadTask = ref.putData(event.imageBytes);

      await uploadTask.whenComplete(() => null);

      String imageUrl = await ref.getDownloadURL();
      // showToast('ImageUrl: $imageUrl');
      event.event.image = imageUrl;
      add(UpdateEvent(event.event));
      add(LoadEvents());
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final events = await eventService.getEvents();
      emit(EventLoaded(events));
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateEvent(
      CreateEvent event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final newEvent = await eventService.createEvent(event.event);
      emit(EventOperationSuccess(newEvent!));
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateEvent(
      UpdateEvent event, Emitter<EventState> emit) async {
    try {
      final updatedEvent = await eventService.updateEvent(event.event);
      emit(EventOperationSuccess(updatedEvent));
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteEvent(
      DeleteEvent event, Emitter<EventState> emit) async {
    try {
      await eventService.deleteEvent(event.id);
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onRSVPEvent(RSVPEvent event, Emitter<EventState> emit) async {
    emit(EventRSVPing());
    try {
      final updatedEvent =
          await eventService.rsvpEvent(event.eventId, event.userId);
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onUnRSVPEvent(
      UnRSVPEvent event, Emitter<EventState> emit) async {
    emit(EventUnRSVPing());
    try {
      final updatedEvent =
          await eventService.unRsvpEvent(event.eventId, event.userId);
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }
}
