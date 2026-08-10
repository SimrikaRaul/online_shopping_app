class AddProductModel {
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  AddProductModel({
    required this.name,
    required this.price,
    required this.description,
     required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "price": price, "description": description,"imageUrl" :imageUrl};
  }
}
