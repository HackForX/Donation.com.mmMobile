import 'package:donation_com_mm_v2/models/sadudithar_response.dart';

class CityResponse {
  final bool status;
  final String message;
  final List<SaduditharCity> data;

  const CityResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<SaduditharCity>.from(
          json['data'].map((dynamic item) => SaduditharCity.fromJson(item as Map<String, dynamic>)),
        ),
      );
}


class SaduditharCity {
  final int id;
  final String name;
  final int isActive;
  final List<Township> townships;
  final String createdAt;
  final String updatedAt;

  SaduditharCity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.townships,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaduditharCity.fromJson(Map<String, dynamic> json) {
    return SaduditharCity(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      townships: List<Township>.from(
          json['townships'].map((dynamic item) => Township.fromJson(item as Map<String, dynamic>)),
        ),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


