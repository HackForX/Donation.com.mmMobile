class CategoryResponse {
  final bool status;
  final String message;
  final List<SaduditharCategory> data;

  const CategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<SaduditharCategory>.from(
          json['data'].map((dynamic item) => SaduditharCategory.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class SaduditharCategory {
  final int id;
  final String name;
  final String type;
  final List<SubCategory> subCategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SaduditharCategory({
    required this.id,
    required this.name,
    required this.type,
    required this.subCategories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaduditharCategory.fromJson(Map<String, dynamic> json) => SaduditharCategory(
        id: json['id'] as int,
        name: json['name'] as String,
    type: json['type'] as String,
    subCategories: List<SubCategory>.from(
          json['sub_categories'].map((dynamic item) => SubCategory.fromJson(item as Map<String, dynamic>)),
        ),
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}


class SubCategory {
  final int id;
  final String name;
  final String type;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubCategory({
    required this.id,
    required this.name,
    required this.type,
    required this.categoryId,

    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        type:json['type'] as String,
        categoryId: json['category_id'] as int,

        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}

