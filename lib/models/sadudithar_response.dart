import 'package:donation_com_mm_v2/models/sadudithar_comment_response.dart';

class SaduditharResponse {
  final bool status;
  final String message;
  final List<Sadudithar> data;

  SaduditharResponse({required this.status, required this.message, required this.data});

  factory SaduditharResponse.fromJson(Map<String, dynamic> json) {
    return SaduditharResponse(
      status: json['status'],
      message: json['message'],
      data: List<Sadudithar>.from(json['data'].map((x) => Sadudithar.fromJson(x))),
    );
  }
}

class Sadudithar {
  final int id;
  final String title;
  final String? description;
  final Category category;
  final City city;
  final Township township;
  final User user;
  final dynamic subCategory;
  final int estimatedAmount;
  final String estimatedTime;
  final String estimatedQuantity;
  final dynamic actualStartTime;
  final dynamic actualEndTime;
  final String eventDate;
  final int isOpen;
  final int isShow;
  final String address;
  final String phone;
  final String image;
  final String status;
  final dynamic latitude;
  final dynamic longitude;
  final int commentCount;
  final int likeCount;
  final int viewCount;
  final SaduditharLike? like;
  final String createdAt;
  final String updatedAt;

  Sadudithar({
    required this.id,
    required this.title,
     this.description,
    required this.category,
    required this.city,
    required this.township,
    required this.user,
    required this.subCategory,
    required this.estimatedAmount,
    required this.estimatedTime,
    required this.estimatedQuantity,
     this.actualStartTime,
     this.actualEndTime,
    required this.eventDate,
    required this.isOpen,
    required this.isShow,
    required this.address,
    required this.phone,
    required this.image,
    required this.status,
     this.latitude,
     this.longitude,
    required this.commentCount,
    required this.likeCount,
    required this.viewCount,
    this.like,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sadudithar.fromJson(Map<String, dynamic> json) {
    return Sadudithar(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      city: City.fromJson(json['city']),
      township: Township.fromJson(json['township']),
      user: User.fromJson(json['user']),
      subCategory: json['sub_category'],
      estimatedAmount: json['estimated_amount'],
      estimatedTime: json['estimated_time'],
      estimatedQuantity: json['estimated_quantity'],
      actualStartTime: json['actual_start_time']??"",
      actualEndTime: json['actual_end_time']??"",
      eventDate: json['event_date'],
      isOpen: json['is_open'],
      isShow: json['is_show'],
      address: json['address'],
      phone: json['phone'],
      image: json['image'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      commentCount: json['comment_count'],
      likeCount: json['like_count'],
      viewCount: json['view_count'],
      like: json['like']==null?null:SaduditharLike.fromJson(json['like']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String type;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class City {
  final int id;
  final String name;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  City({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Township {
  final int id;
  final String name;
  final int isActive;
  final int cityId;
  final String cityName;
  final String createdAt;
  final String updatedAt;

  Township({
    required this.id,
    required this.name,
    required this.isActive,
    required this.cityId,
    required this.cityName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final dynamic address;
  final dynamic profile;
  final dynamic document;
  final dynamic documentNumber;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.profile,
    required this.document,
    required this.documentNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      profile: json['profile'],
      document: json['document'],
      documentNumber: json['document_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
