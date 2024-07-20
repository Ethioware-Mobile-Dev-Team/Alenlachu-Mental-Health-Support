import 'package:alenlachu_app/data/user/models/chat_message.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});

  @override
  List<Object?> get props => [error];
}
