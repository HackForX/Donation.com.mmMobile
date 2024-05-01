class ItemResponse {
  final bool status;
  final String message;
  final List<Item> data;

  const ItemResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) => ItemResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: List<Item>.from(
          json['data'].map((dynamic item) => Item.fromJson(item as Map<String, dynamic>)),
        ),
      );
}

class Item {
  final int id;
  final String name;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    required this.id,
    required this.name,

    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int,
        name: json['name'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
