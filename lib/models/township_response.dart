import 'package:donation_com_mm_v2/models/sadudithar_response.dart';

class TownshipResponse {
  final bool status;
  final String message;
  final List<Township> data;

  const TownshipResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TownshipResponse.fromJson(Map<String, dynamic> json) => TownshipResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<Township>.from(
          json['data'].map((dynamic item) => Township.fromJson(item as Map<String, dynamic>)),
        ),
      );
}
