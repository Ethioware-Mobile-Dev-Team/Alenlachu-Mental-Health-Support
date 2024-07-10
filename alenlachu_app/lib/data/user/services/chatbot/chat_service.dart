import 'dart:convert';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:alenlachu_app/data/user/models/chat_message.dart';

class ChatService {
  static const String _baseUrl = 'http://192.168.99.212:3000/api';

  static Future<List<ChatMessage>> getChatHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final response =
        await http.get(Uri.parse('$_baseUrl/chat-history?userId=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> chatHistoryJson = json.decode(response.body);
      showToast("Feching data......");
      return chatHistoryJson.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      showToast("Erorrr");
      throw Exception('Failed to load chat history');
    }
  }

  static Future<String> sendMessage(String message) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    // showToast("Feching data......");
    final response = await http.post(
      Uri.parse('$_baseUrl/send-message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': message,
        'userId': userId,
      }),
    );
    // showToast("Feching data complated");
    if (response.statusCode == 200) {
      // showToast("data found");
      final responseBody = jsonDecode(response.body);
      return responseBody['reply'];
    } else {
      // showToast("Data Faild......");
      throw Exception('Failed to send message');
    }
  }
}
