import 'package:meta/meta.dart';

class RegisterResponse {
  final String token;
  final String message;
  final UserData user;

  RegisterResponse({
    required this.token,
    required this.message,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'] as String,
      message: json['message'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String phone;


  UserData({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
