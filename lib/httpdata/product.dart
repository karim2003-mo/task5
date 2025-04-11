class Product {
  String? id;
  String? category;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  double? rating;
  double? offer;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.offer,
    required this.category,
  });
  static convert_to_product(List products){
    List<Product> productList = [];
    for (var product in products) {
      Product p = Product(
        id: product['id'],
        name: product['name'],
        description: product['description'],
        price: product['price'].toDouble(),
        imageUrl: product['image'],
        rating: product['rating'].toDouble(),
        offer:(product['offer']!=null)? product['offer'].toDouble():null,
        category: product['category'],
      );
      productList.add(p);
    }
    return productList;
  }
}