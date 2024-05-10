import 'package:donation_com_mm_v2/models/natebanzay_response.dart';

class NatebanzayRequestFromNatebanzayResponse {
  final bool status;
  final String message;
  final List<NatebanzayRequestFromNatebanzay> data;

  NatebanzayRequestFromNatebanzayResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NatebanzayRequestFromNatebanzayResponse.fromJson(Map<String, dynamic> json) {
    return NatebanzayRequestFromNatebanzayResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => NatebanzayRequestFromNatebanzay.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class NatebanzayRequestFromNatebanzay {
  final int id;
  final int uploaderId;
  final int requesterId;
  final User requester;
  final int natebanzayId;
  final String status;

  NatebanzayRequestFromNatebanzay({
    required this.id,
    required this.uploaderId,
    required this.requesterId,
    required this.requester,
    required this.natebanzayId,
    required this.status,
  });

  factory NatebanzayRequestFromNatebanzay.fromJson(Map<String, dynamic> json) {
    return NatebanzayRequestFromNatebanzay(
      id: json['id'],
      uploaderId: json['uploader_id'],
      requesterId: json['requester_id'],
      requester: User.fromJson(json['requester']),

      natebanzayId: json['natebanzay_id'] as int,

      status: json['status'] as String,
    );
  }
}
