import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:equatable/equatable.dart';

abstract class AwarenessState extends Equatable {
  const AwarenessState();

  @override
  List<Object> get props => [];
}

class AwarenessInitial extends AwarenessState {}

class AwarenessLoading extends AwarenessState {}

class AwarenessLoaded extends AwarenessState {
  final List<AwarenessModel> awarenesss;

  const AwarenessLoaded(this.awarenesss);

  @override
  List<Object> get props => [awarenesss];
}

class AwarenessOperationSuccess extends AwarenessState {
  final AwarenessModel awareness;

  const AwarenessOperationSuccess(this.awareness);

  @override
  List<Object> get props => [awareness];
}

class AwarenessOperationFailure extends AwarenessState {
  final String error;

  const AwarenessOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
