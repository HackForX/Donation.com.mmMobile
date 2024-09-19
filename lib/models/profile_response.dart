class ProfileResponse {
  final bool status;
  final String message;
  
  final Profile data;

  const ProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: Profile.fromJson(json['data'])
      );
}

class Profile {
  final int id;
  final String name;
  final String phone;
  final String role;
  final dynamic profile; // Can be null
  final dynamic document; // Can be null
  final dynamic isShow;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Profile({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.profile,
    this.document,
    required this.createdAt,
    required this.isShow,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        role: json['role'],
        profile: json['profile'],
        document: json['document'],
        isShow: json['is_show'],
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
