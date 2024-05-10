import 'package:donation_com_mm_v2/models/item_response.dart';
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
  final int natebanzayId;
  final int uploaderId;
  final int requesterId;
  final User requester;
  final User uploader;
  final RequestNatebanzay natebanzay;
  final String status;

  NatebanzayRequest({
     required this.uploaderId,
     required this.requesterId,
    required this.natebanzayId,
    required this.natebanzay,
    required this.requester,
    required this.uploader,
    required this.status,
  });

  factory NatebanzayRequest.fromJson(Map<String, dynamic> json) {
    return NatebanzayRequest(
      requesterId: json['requester_id'],
      uploaderId: json['uploader_id'],

      uploader:User.fromJson(json['uploader']),

      requester:User.fromJson(json['requester']),

      natebanzayId: json['natebanzay_id'] as int,
      natebanzay: RequestNatebanzay.fromJson(json['natebanzay'] ),
      status: json['status'] as String,
    );
  }
}


class RequestNatebanzay {
  final int id;
  final String name;
  final String quantity;
  final String address;
  final String phone;
  final String? note; // Can be null
  final User? user;
  final String? photos; // Can be null (handle as a list of strings)
  final String status;
  final Item item;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RequestNatebanzay({
    required this.id,
    required this.name,
    required this.quantity,
    required this.address,
    required this.phone,
    required this.item,
    this.note,
    this.photos,
     this.user,
    // this.photos,
    required this.status,

    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestNatebanzay.fromJson(Map<String, dynamic> json) => RequestNatebanzay(
        id: json['id'] as int,
        name: json['name'] as String,
        quantity: json['quantity'] ,
        address: json['address'] as String,
        phone: json['phone'] as String,
        note: json['note'] as String?,
        item: Item.fromJson(json['item'],),
        user: json['user']==null?null:User.fromJson(json['user']),
        photos: json['photos'],
        status: json['status'] as String,
    
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}

