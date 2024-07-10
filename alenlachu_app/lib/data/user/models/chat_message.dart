class ChatMessage {
  final String userId;
  final DateTime time;
  final String message;
  final bool isSender;

  ChatMessage({required this.userId,required this.time, required this.message, required this.isSender});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      userId:json['userId'],
      time: DateTime.parse(json['time']),
      message: json['message'],
      isSender: json['isSender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'message': message,
      'isSender': isSender,
    };
  }
}
