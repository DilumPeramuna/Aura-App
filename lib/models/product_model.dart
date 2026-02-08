import '../core/api_constants.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String? image1;
  final String? image2;
  final String? image3;
  final String description;
  final String category;
  final String metal;
  final String gem;
  final int quantity;
  final bool isPick;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.image1,
    this.image2,
    this.image3,
    required this.description,
    required this.category,
    required this.metal,
    required this.gem,
    required this.quantity,
    required this.isPick,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: ApiConstants.getImageUrl(json['image']),
      image1: json['image_1'] != null ? ApiConstants.getImageUrl(json['image_1']) : null,
      image2: json['image_2'] != null ? ApiConstants.getImageUrl(json['image_2']) : null,
      image3: json['image_3'] != null ? ApiConstants.getImageUrl(json['image_3']) : null,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      metal: json['metal'] ?? '',
      gem: json['gem'] ?? '',
      quantity: json['quantity'] ?? 0,
      isPick: (json['is_pick'] == 1 || json['is_pick'] == '1' || json['is_pick'] == true),
    );
  }
}
