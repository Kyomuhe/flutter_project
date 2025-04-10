class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final int rating;
  final int discount;
  final String vendorName;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.discount,
    required this.vendorName,
  });
}