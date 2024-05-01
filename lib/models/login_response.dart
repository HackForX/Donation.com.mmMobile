import 'package:donation_com_mm_v2/models/register_response.dart';
import 'package:meta/meta.dart';

class LoginResponse {
  final String token;
  final String message;
  final UserData user;

  LoginResponse({
    required this.token,
    required this.message,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      message: json['message'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
