import 'package:equatable/equatable.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> events;

  const EventLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventOperationSuccess extends EventState {
  final EventModel event;

  const EventOperationSuccess(this.event);

  @override
  List<Object> get props => [event];
}

class EventOperationFailure extends EventState {
  final String error;

  const EventOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
