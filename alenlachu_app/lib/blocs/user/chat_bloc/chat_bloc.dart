import 'package:alenlachu_app/blocs/user/chat_bloc/chat_event.dart';
import 'package:alenlachu_app/blocs/user/chat_bloc/chat_state.dart';
import 'package:alenlachu_app/data/user/models/chat_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alenlachu_app/data/user/services/chatbot/chat_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc(this.chatService) : super(ChatInitial()) {
    on<LoadChatHistory>(_onLoadChatHistory);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadChatHistory(
      LoadChatHistory event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final history = await chatService.getChatHistory();
      emit(ChatLoaded(messages: history));
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final updatedHistory = List<ChatMessage>.from(currentState.messages)
        ..add(ChatMessage(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          time: DateTime.now(),
          message: event.message,
          isSender: true,
        ));
      emit(ChatLoaded(messages: updatedHistory));

      try {
        final reply = await chatService.sendMessage(event.message);
        updatedHistory.add(ChatMessage(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          time: DateTime.now(),
          message: reply,
          isSender: false,
        ));
        add(LoadChatHistory());
        // emit(ChatLoaded(messages: updatedHistory));
      } catch (e) {
        emit(ChatError(error: e.toString()));
      }
    }
  }
}
