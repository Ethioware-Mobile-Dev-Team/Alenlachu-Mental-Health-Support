import 'package:equatable/equatable.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class CreateEvent extends EventEvent {
  final EventModel event;

  const CreateEvent(this.event);

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventEvent {
  final String id;
  final EventModel event;

  const UpdateEvent(this.id, this.event);

  @override
  List<Object> get props => [id, event];
}

class DeleteEvent extends EventEvent {
  final String id;

  const DeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RSVPEvent extends EventEvent {
  final String eventId;
  final String userId;

  const RSVPEvent(this.eventId, this.userId);

  @override
  List<Object> get props => [eventId, userId];
}

class UnRSVPEvent extends EventEvent {
  final String eventId;
  final String userId;

  const UnRSVPEvent(this.eventId, this.userId);

  @override
  List<Object> get props => [eventId, userId];
}
