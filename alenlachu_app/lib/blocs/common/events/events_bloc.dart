import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/services/event_services.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventService eventService;

  EventBloc(this.eventService) : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<CreateEvent>(_onCreateEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<RSVPEvent>(_onRSVPEvent);
    on<UnRSVPEvent>(_onUnRSVPEvent);
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
      final updatedEvent =
          await eventService.updateEvent(event.id, event.event);
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
    try {
      final updatedEvent =
          await eventService.rsvpEvent(event.eventId, event.userId);
      emit(EventOperationSuccess(updatedEvent));
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }

  Future<void> _onUnRSVPEvent(
      UnRSVPEvent event, Emitter<EventState> emit) async {
    try {
      final updatedEvent =
          await eventService.unRsvpEvent(event.eventId, event.userId);
      emit(EventOperationSuccess(updatedEvent));
      add(LoadEvents());
    } catch (e) {
      emit(EventOperationFailure(e.toString()));
    }
  }
}
