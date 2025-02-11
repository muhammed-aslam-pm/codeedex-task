import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final String categoryName;
  final double price;
  final double offerPrice;
  final String discount;
  final String description;
  final String imageUrl;
  final bool isAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.offerPrice,
    required this.discount,
    required this.description,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      categoryName: json['category_name'],
      price: double.parse(json['price']),
      offerPrice: json['offer_price'] ?? 0.0,
      discount: json['discount'].toString(),
      description: json['description'] ?? '',
      imageUrl: json['images'].isNotEmpty ? json['images'][0]['image'] : '',
      isAvailable: json['Available'],
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
