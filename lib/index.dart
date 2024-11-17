class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(), // Converte ID para String
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      imageUrl: json['imageUrl'],
    );
  }
}
