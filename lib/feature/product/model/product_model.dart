class ProductModel {
  final String? id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}