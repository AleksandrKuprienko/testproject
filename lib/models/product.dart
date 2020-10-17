class Product {
  final String title;
  final String description;
  final String imageUrl;
  final String price;

  Product({
    this.title,
    this.description,
    this.imageUrl,
    this.price,
  });

  Map<String, dynamic> toFirebase() => {
        'title': this.title,
        'description': this.description,
        'imageUrl': this.imageUrl,
        'price': this.price,
      };

  factory Product.fromFirebase(Map<String, dynamic> data) => Product(
        title: data['title'],
        description: data['description'],
        imageUrl: data['imageUrl'],
        price: data['price'],
      );
}
