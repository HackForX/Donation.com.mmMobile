import 'package:donation_com_mm_v2/models/item_response.dart';

class NatebanzayResponse {
  final bool status;
  final String message;
  final List<Natebanzay> data;

  const NatebanzayResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NatebanzayResponse.fromJson(Map<String, dynamic> json) => NatebanzayResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<Natebanzay>.from(
          json['data'].map((dynamic item) => Natebanzay.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class Natebanzay {
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
  final int requestedCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Natebanzay({
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
    required this.requestedCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Natebanzay.fromJson(Map<String, dynamic> json) => Natebanzay(
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
        requestedCount:json['requested_count'],
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}

class User {
  final int id;
  final String name;
  final String phone;
  final String? address; // Can be null
  final String? profile; // Can be null
  final String? document; // Can be null
  final String? documentNumber; // Can be null
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.profile,
    this.document,
    this.documentNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String?,
        profile: json['profile'] as String?,
        document: json['document'] as String?,
        documentNumber: json['document_number'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
