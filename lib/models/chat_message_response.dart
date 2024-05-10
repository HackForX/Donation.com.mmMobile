class ChatMessageResponse {
  final bool status;
  final String message;
  final List<ChatMessage> data;

  const ChatMessageResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) => ChatMessageResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<ChatMessage>.from(
          json['data'].map((dynamic item) => ChatMessage.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class ChatMessage {
  final int id;
  final int chatId;
  final int receiverId;
  final int senderId;
  final String message;

  final DateTime createdAt;

  const ChatMessage( {
    
    required this.id,
  required  this.chatId,required this.receiverId,required this.senderId,
    required this.message,

    required this.createdAt,
 
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as int,
        chatId: json['chat_id'] as int,
        senderId: json['sender_id'] as int,
        receiverId: json['receiver_id'] as int,
        message: json['message'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),

      );
}
