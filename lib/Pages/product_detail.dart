import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../Components/cart.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  String formatCurrency(double amount) {
    return 'Ugx ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    // Access CartProvider
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    
    // Calculate original price based on discount
    final originalPrice = product.price / (1 - product.discount / 100);
    
    // Track quantity
    int quantity = 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xB861CEFF), // bluish with opacity
              Colors.white,      // transition to white
              Colors.white,      // solid white
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top header with back button and "Details" text
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 24.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/icon.png', 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D2D2D),
                      ),
                      ),
                    ],
                  ),
                ),
                
                // Product name and composition (unchanged)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 23.0, right: 23.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                  child: Text(
                    'Composition: ${product.description}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: Colors.blue,
                    ),
                  ),
                ),
                
                // Product images section (unchanged)
                Padding(
                  padding: const EdgeInsets.only(top: 27.0, left: 18.0, right: 18.0),
                  child: SizedBox(
                    height: 238,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left image selector column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Up arrow
                            Container(
                              width: 44,
                              height: 20,
                              alignment: Alignment.center,
                              child: const Icon(Icons.keyboard_arrow_up, color: Colors.blue, size: 14),
                            ),
                            
                            // Image thumbnails
                            const SizedBox(height: 5),
                            ...List.generate(3, (index) => 
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      product.imageUrl,
                                      width: 28,
                                      height: 24,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            ),
                            
                            // Down arrow
                            const SizedBox(height: 5),
                            Container(
                              width: 44,
                              height: 20,
                              alignment: Alignment.center,
                              child: const Icon(Icons.keyboard_arrow_down, color: Colors.blue, size: 14),
                            ),
                          ],
                        ),
                        
                        const SizedBox(width: 17),
                        
                        // Main product image
                        Expanded(
                          child: Container(
                            height: 238,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F0FB),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Image.asset(
                                product.imageUrl,
                                height: 140,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Price section (unchanged)
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 85.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                formatCurrency(originalPrice),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  '${product.discount}% OFF',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 14),
                      
                      // Current price
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          formatCurrency(product.price),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0085FF),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                
                // Policy and product info (unchanged)
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 22.0, right: 22.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.check_circle_outline, 'Policy', 'Non Returnable'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.check_circle_outline, 'Expires on', '26 Feb 2029'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.check_circle_outline, 'Mfr / Marketer', '${product.vendorName} pvt ltd'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.check_circle_outline, 'Consume type', 'Oral'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            '262 Sold in the last 24 hours',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0064D2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Product tabs (unchanged)
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 43,
                  color: const Color(0xFF0064D2).withOpacity(0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTabItem('Product Details', isSelected: true),
                      _buildTabItem('Safety Advice'),
                      _buildTabItem('Reviews'),
                      _buildTabItem('Substitutes'),
                    ],
                  ),
                ),
                
                // Quantity selector - UPDATED with state management
                StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 22.0, right: 22.0),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Minus button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                                color: Color(0xFF0085FF),
                              ),
                            ),
                          ),
                          // Divider
                          Container(width: 1, color: Colors.grey[300]),
                          // Quantity display
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // Divider
                          Container(width: 1, color: Colors.grey[300]),
                          // Plus button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {
                                setState(() => quantity++);
                              },
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Color(0xFF0085FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                // Add to cart button - UPDATED with proper functionality
                Container(
                  margin: const EdgeInsets.only(top: 15.0, left: 22.0, right: 22.0, bottom: 30.0),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add product to cart with selected quantity
                      for (int i = 0; i < quantity; i++) {
                        cartProvider.addItem(product);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(cartProvider: cartProvider),
                          ),
                          );

                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} (x$quantity) added to cart'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0085FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/vector_copy.png',
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper methods (unchanged)
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 11, color: Colors.black),
        const SizedBox(width: 10),
        Text(
          '$label : ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTabItem(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: isSelected
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Color(0xFF0064D2)),
              ),
            )
          : null,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: isSelected ? const Color(0xFF0064D2) : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}