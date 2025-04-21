import 'package:flutter/material.dart';
import '../Components/product_card.dart';
import '../models/product.dart'; 
import '../Components/cart.dart';
import '../Components/notification_service.dart'; // Import notification components
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  static List<Product> getSampleProducts(){
    return [
      Product(
        id: '1',
        name: 'Hydrocodone',
        imageUrl: 'assets/product.png',
        description: 'High-quality pain relief medication',
        price: 199999,
        rating: 4,
        discount: 15,
        vendorName: 'AudioTech',
      ),
      Product(
        id: '2',
        name: 'Pacimal tabs',
        imageUrl: 'assets/product2.PNG',
        description: 'Effective fever and pain reliever',
        price: 299999,
        rating: 5,
        discount: 10,
        vendorName: 'TechGear',
      ),
      Product(
        id: '3',
        name: 'Losarta',
        imageUrl: 'assets/product4.PNG',
        description: 'Blood pressure medication',
        price: 89999,
        rating: 4,
        discount: 20,
        vendorName: 'PowerPlus',
      ),
      Product(
        id: '4',
        name: 'Metformin',
        imageUrl: 'assets/product3.PNG',
        description: 'Type 2 diabetes management',
        price: 149999,
        rating: 5,
        discount: 5,
        vendorName: 'HealthPlus',
      ),
      Product(
        id: '5',
        name: 'Amoxicillin',
        imageUrl: 'assets/product2.PNG',
        description: 'Antibiotic for bacterial infections',
        price: 129999,
        rating: 4,
        discount: 12,
        vendorName: 'MedCare',
      ),
      Product(
        id: '6',
        name: 'Omeprazole',
        imageUrl: 'assets/product4.PNG',
        description: 'Acid reflux and heartburn relief',
        price: 79999,
        rating: 4,
        discount: 8,
        vendorName: 'DigestCare',
      ),
      Product(
        id: '7',
        name: 'Atorvastatin',
        imageUrl: 'assets/product3.PNG',
        description: 'Cholesterol-lowering medication',
        price: 189999,
        rating: 5,
        discount: 15,
        vendorName: 'HeartHealth',
      ),
      Product(
        id: '8',
        name: 'Ibuprofen',
        imageUrl: 'assets/product2.PNG',
        description: 'Anti-inflammatory pain reliever',
        price: 59999,
        rating: 4,
        discount: 10,
        vendorName: 'PainRelief',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final products = getSampleProducts();
    // Getting the CartProvider from the widget tree
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    
    
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32,
                      width:344,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommended for you',
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 16,
                            ),
                          ),
                          
                        
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllProductsPage(
                                    products: products,
                                    cartProvider: cartProvider, // Passing cartProvider 
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Explore all',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    SizedBox(
                      height: 278, 
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length > 4 ? 4 : products.length, // Show only first 4 products
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: products[index],
                            onProductSelect: (productId) {
                              // This callback is now handled in the ProductCard itself
                              print('Selected product ID: $productId');
                            },
                            cartProvider: cartProvider, // Pass the cart provider to the ProductCard
                          );
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          
          // Floating Cart Button - show only if cart has items
          if (cartProvider.itemCount > 0)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingCartButton(
                  cartProvider: cartProvider,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cartProvider: cartProvider),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Page that displays all products in a grid with two columns
class AllProductsPage extends StatelessWidget {
  final List<Product> products;
  final CartProvider cartProvider; 

  const AllProductsPage({
    Key? key, 
    required this.products,
    required this.cartProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar - custom header instead
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Custom header with back button and "All products" text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      // "All products" text
                      const Text(
                        'All products',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Grid of products
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.55, // Adjusted to match product card proportions
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onProductSelect: (productId) {
                            print('Selected product ID: $productId');
                          },
                          cartProvider: cartProvider, // Pass the cartProvider
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Cart Button - show only if cart has items
          if (cartProvider.itemCount > 0)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingCartButton(
                  cartProvider: cartProvider,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cartProvider: cartProvider),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}