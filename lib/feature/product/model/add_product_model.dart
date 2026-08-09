class AddProductModel {
  final String name;
  final String price;
  final String description;

  AddProductModel({
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "description": description,
    };
  }
}