import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alenlachu_app/data/user/models/chat_message.dart';
import 'package:alenlachu_app/data/user/services/chatbot/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _chatHistory = [];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  void _loadChatHistory() async {
    final history = await ChatService.getChatHistory();
    setState(() {
      _chatHistory = history;
    });
  }

  void _sendMessage() async {
    final message = _chatController.text;
    if (message.isNotEmpty) {
      setState(() {
        _chatHistory.add(ChatMessage(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          time: DateTime.now(),
          message: message,
          isSender: true,
        ));
        _chatController.clear();
      });
      _scrollToBottom();
      final reply = await ChatService.sendMessage(message);
      setState(() {
        _chatHistory.add(ChatMessage(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          time: DateTime.now(),
          message: reply,
          isSender: false,
        ));
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Assistant'),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final chatMessage = _chatHistory[index];
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
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: Colors.white,
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
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
