class NotificationResponse {
  final bool status;
  final String message;
  final List<Notification> data;

  const NotificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<Notification>.from(
          json['data'].map((dynamic item) => Notification.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class Notification {
  final int id;
  final String title;
  final String body;
  final String createdAt;


  const Notification({
    required this.id,
    required this.title,
required this.body,
    required this.createdAt,

  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: json['created_at'],
       
      );
}
