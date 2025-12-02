class Product {
  String image, name, description, category;
  int price;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.category,
      required this.price});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        image: json['image'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        price: json['price']);
  }
}
