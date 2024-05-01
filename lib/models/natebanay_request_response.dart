import 'package:donation_com_mm_v2/models/natebanzay_response.dart';

class NatebanzayRequestResponse {
  final bool status;
  final String message;
  final List<NatebanzayRequest> data;

  NatebanzayRequestResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NatebanzayRequestResponse.fromJson(Map<String, dynamic> json) {
    return NatebanzayRequestResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => NatebanzayRequest.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class NatebanzayRequest {
  final int userId;

  final int natebanzayId;
  final Natebanzay natebanzay;
  final String status;

  NatebanzayRequest({
    required this.userId,
 
    required this.natebanzayId,
    required this.natebanzay,
    required this.status,
  });

  factory NatebanzayRequest.fromJson(Map<String, dynamic> json) {
    return NatebanzayRequest(
      userId: json['user_id'] as int,

      natebanzayId: json['natebanzay_id'] as int,
      natebanzay: Natebanzay.fromJson(json['natebanzay'] ),
      status: json['status'] as String,
    );
  }
}
