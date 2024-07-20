import 'package:alenlachu_app/blocs/user/chat_bloc/chat_bloc.dart';
import 'package:alenlachu_app/blocs/user/chat_bloc/chat_event.dart';
import 'package:alenlachu_app/blocs/user/chat_bloc/chat_state.dart';
import 'package:alenlachu_app/blocs/user/journal_bloc/journal_bloc.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(LoadChatHistory());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatLoaded) {
                if (state.messages.isEmpty) {
                  return const Center(
                    child: StyledText(
                      lable:
                          'Hello there, I am your Assistant. share me your feelings',
                      size: 14,
                      color: Colors.grey,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final chatMessage = state.messages[index];
                    return Align(
                      alignment: chatMessage.isSender
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: chatMessage.isSender
                              ? Colors.lightBlueAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          chatMessage.message,
                          style: TextStyle(
                              color: chatMessage.isSender
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ChatError) {
                return Center(child: Text(state.error));
              } else {
                return const Center(
                  child: StyledText(
                    lable: 'Hello there, share me your feelings',
                    size: 14,
                    color: Colors.grey,
                  ),
                );
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8.0),
                      fillColor: Colors.grey[200],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.lightBlueAccent),
                  onPressed: () {
                    final message = _chatController.text;
                    if (message.isNotEmpty) {
                      context
                          .read<ChatBloc>()
                          .add(SendMessage(message: message));
                      _chatController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
