import 'dart:typed_data';

import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:equatable/equatable.dart';

abstract class AwarenessEvent extends Equatable {
  const AwarenessEvent();

  @override
  List<Object> get props => [];
}

class LoadAwareness extends AwarenessEvent {}

class CreateAwareness extends AwarenessEvent {
  final AwarenessModel awareness;

  const CreateAwareness(this.awareness);

  @override
  List<Object> get props => [awareness];
}

class UpdateAwareness extends AwarenessEvent {
  final AwarenessModel awareness;

  const UpdateAwareness(this.awareness);

  @override
  List<Object> get props => [awareness];
}

class UpdateAwarenessImage extends AwarenessEvent {
  final Uint8List imageBytes;
  final AwarenessModel awareness;
  const UpdateAwarenessImage(
      {required this.imageBytes, required this.awareness});
}

class DeleteAwareness extends AwarenessEvent {
  final String id;

  const DeleteAwareness(this.id);

  @override
  List<Object> get props => [id];
}
