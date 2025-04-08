import 'package:flutter/material.dart';
import 'rating_widget.dart';

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

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(String) onProductSelect;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onProductSelect,
  }) : super(key: key);

  String formatCurrency(double amount) {
    return 'Ugx ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    // Calculate original price based on discount
    final originalPrice = product.price / (1 - product.discount / 100);

    return Container(
      width: 189,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF3B82F6)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, 
        children: [
          // Top section container for image and badge
          Stack(
            clipBehavior: Clip.none, 
            children: [
              Container(
                width: double.infinity,
                height: 152,
              ),
              // Discount badge (conditional)
              if (product.discount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 48,
                    height: 47,
                    decoration: const BoxDecoration(
                      color: Color(0xBF3B82F6), // With opacity 0.75
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '-${product.discount}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              // Product image - clickable
              Positioned(
                top: 35,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => onProductSelect(product.id),
                  child: Center(
                    child: SizedBox(
                      width: 102,
                      height: 100,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Product details section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Vendor name and stars
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By ${product.vendorName}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    RatingWidget(rating: product.rating),
                  ],
                ),
                
                // Separator line
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                
                // Previous price (crossed out) if discount exists
                if (product.discount > 0)
                  Text(
                    formatCurrency(originalPrice),
                    style: TextStyle(
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                
                const SizedBox(height: 4),
                
                // Current price and add to cart
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        formatCurrency(product.price),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    // Add to cart text
                    TextButton(
                      onPressed: () {
                        // Add to cart functionality would go here
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}