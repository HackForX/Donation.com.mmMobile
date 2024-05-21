import 'package:donation_com_mm_v2/models/natebanzay_response.dart';

class NatebanzayCommentResponse {
  final bool status;
  final String message;
  final List<NatebanzayComment> data;

  const NatebanzayCommentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NatebanzayCommentResponse.fromJson(Map<String, dynamic> json) => NatebanzayCommentResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<NatebanzayComment>.from(
          json['data'].map((dynamic item) => NatebanzayComment.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class NatebanzayComment {
  final int? natebanzayId;
  final int? userId;
  final User user;
  final String comment;
  final String createdAt;
  

  const NatebanzayComment({
    required this.natebanzayId,
    required this.userId,
required this.user,
    required this.comment,
    required this.createdAt

  });

  factory NatebanzayComment.fromJson(Map<String, dynamic> json) => NatebanzayComment(
        natebanzayId: json['natebanzay_id'] ,
        userId: json['user_id']as int ,

        user: User.fromJson(json['user']),
    comment: json['comment'],
    createdAt: json['created_at']
      );
}



class NatebanzayLike {
  final int natebanzayId;
  final int userId;
  
  

  const NatebanzayLike({
    required this.natebanzayId,
    required this.userId,


  });

  factory NatebanzayLike.fromJson(Map<String, dynamic> json) => NatebanzayLike(
        natebanzayId: json['natebanzay_id'] as int,
        userId: json['user_id'] as int,

  
      );
}
