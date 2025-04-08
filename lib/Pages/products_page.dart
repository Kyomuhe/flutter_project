import 'package:flutter/material.dart';
import '../Components/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // Create sample product data
  List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Hydrocodone',
        imageUrl: 'assets/product3.PNG',
        description: 'High-quality wireless headphones with noise cancellation',
        price: 199999,
        rating: 4,
        discount: 15,
        vendorName: 'AudioTech',
      ),
      Product(
        id: '2',
        name: 'Pacimal tabs',
        imageUrl: 'assets/product2.PNG',
        description: 'Fitness tracker with heart rate monitor',
        price: 299999,
        rating: 5,
        discount: 10,
        vendorName: 'TechGear',
      ),
      Product(
        id: '4',
        name: 'Losarta',
        imageUrl: 'assets/product4.PNG',
        description: '20000mAh fast charging power bank',
        price: 89999,
        rating: 4,
        discount: 20,
        vendorName: 'PowerPlus',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final products = getSampleProducts();
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
          width: 344,
          height: 32,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "Shop by condition" text
              const Text(
                'Recommeded for you',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 20,
                ),
              ),
              
              // "Explore all" text - clickable
                const Text(
                  'Explore all',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              
            ],
          ),
        ),
                const SizedBox(height: 16),
                
                // Container with fixed height to display products in a single row
                SizedBox(
                  height: 278, // The exact height of our ProductCard
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: products[index],
                        onProductSelect: (productId) {
                          // Handle product selection, e.g., navigate to detail page
                          print('Selected product ID: $productId');
                        },
                      );
                    },
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}