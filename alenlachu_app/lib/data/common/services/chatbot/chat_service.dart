import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:alenlachu_app/data/common/models/chat_message.dart';

class ChatService {
  static const String _baseUrl = 'http://172.20.10.9:3000/api';

  static Future<List<ChatMessage>> getChatHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final response = await http.get(Uri.parse('$_baseUrl/chat-history?userId=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> chatHistoryJson = json.decode(response.body);
      return chatHistoryJson.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chat history');
    }
  }

  static Future<String> sendMessage(String message) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final response = await http.post(
      Uri.parse('$_baseUrl/send-message'),
      headers:{'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': message,
        'userId': userId,
        }),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['reply'];
    } else {
      throw Exception('Failed to send message');
    }
  }
}
