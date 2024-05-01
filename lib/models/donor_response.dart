class DonorResponse {
  final bool status;
  final String message;
  final List<Donor> data;

  const DonorResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DonorResponse.fromJson(Map<String, dynamic> json) => DonorResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<Donor>.from(
          json['data'].map((dynamic item) => Donor.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class Donor {
  final int id;
  final String name;
  final String phone;
  final dynamic profile; // Can be null
  final dynamic document; // Can be null
  final DateTime createdAt;
  final DateTime updatedAt;

  const Donor({
    required this.id,
    required this.name,
    required this.phone,
    this.profile,
    this.document,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        profile: json['profile'],
        document: json['document'],
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
