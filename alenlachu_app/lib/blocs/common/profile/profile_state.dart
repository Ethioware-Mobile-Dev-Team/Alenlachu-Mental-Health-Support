import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class Updating extends ProfileState {}

class Updated extends ProfileState {}

class NotUpdated extends ProfileState {
  final String error;
  NotUpdated(this.error);

  @override
  List<Object> get props => [error];
}

class ImagePicked extends ProfileState {
  final String image;

  ImagePicked({required this.image});
}
