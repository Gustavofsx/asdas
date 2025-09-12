class Vehicle {
  final String id;
  final String brand;
  final String model;
  final int year;
  final String color;
  final double price;
  final int stockQuantity;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
    required this.stockQuantity,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      color: json['color'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      stockQuantity: json['stockQuantity'] ?? 0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'price': price,
      'stockQuantity': stockQuantity,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Vehicle copyWith({
    String? id,
    String? brand,
    String? model,
    int? year,
    String? color,
    double? price,
    int? stockQuantity,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
