import 'package:donation_com_mm_v2/models/natebanzay_response.dart';

class SaduditharCommentResponse {
  final bool status;
  final String message;
  final List<SaduditharComment> data;

  const SaduditharCommentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaduditharCommentResponse.fromJson(Map<String, dynamic> json) => SaduditharCommentResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<SaduditharComment>.from(
          json['data'].map((dynamic item) => SaduditharComment.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class SaduditharComment {
  final int saduditharId;
  final int userId;
  final User user;
  final String comment;
  final String createdAt;
  

  const SaduditharComment({
    required this.saduditharId,
    required this.userId,
required this.user,
    required this.comment,
    required this.createdAt

  });

  factory SaduditharComment.fromJson(Map<String, dynamic> json) => SaduditharComment(
        saduditharId: json['sadudithar_id'] as int,
        userId: json['sadudithar_id'] as int,

        user: User.fromJson(json['user']),
    comment: json['comment'],
    createdAt: json['created_at']
      );
}



class SaduditharLike {
  final int saduditharId;
  final int userId;
  
  

  const SaduditharLike({
    required this.saduditharId,
    required this.userId,


  });

  factory SaduditharLike.fromJson(Map<String, dynamic> json) => SaduditharLike(
        saduditharId: json['sadudithar_id'] as int,
        userId: json['sadudithar_id'] as int,

  
      );
}
