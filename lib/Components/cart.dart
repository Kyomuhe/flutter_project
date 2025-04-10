import 'package:flutter/material.dart';
import '../models/product.dart'; // Import the consolidated Product model

// Cart Item model
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

// Cart Provider to manage state
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  
  double get shippingCharges => 5000; // Fixed shipping charges
  
  double get cashBack => subtotal * 0.02; // 2% cashback
  
  double get savedOnOrder => _items.fold(0, (sum, item) {
    final originalPrice = item.product.price / (1 - item.product.discount / 100);
    return sum + ((originalPrice - item.product.price) * item.quantity);
  });
  
  double get total => subtotal + shippingCharges - cashBack;

  void addItem(Product product) {
    final existingItemIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingItemIndex != -1) {
      // Product already in cart, increase quantity
      _items[existingItemIndex].quantity++;
    } else {
      // Add new product to cart
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        // Remove item if quantity becomes 0
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// The Cart Page
class CartPage extends StatelessWidget {
  final CartProvider cartProvider;

  const CartPage({Key? key, required this.cartProvider}) : super(key: key);

  String formatCurrency(double amount) {
    return 'Ugx ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x61CEFFB8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
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
            const SizedBox(width: 10),
            const SizedBox(
              width: 129,
              height: 18,
              child: Text(
                'Shopping Cart',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Cart items list
          Expanded(
            child: cartProvider.items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Dismissible(
                          key: Key(cartItem.product.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: const Color(0xFFEF574B),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          onDismissed: (direction) {
                            cartProvider.removeItem(cartItem.product.id);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 86,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Product Image Container
                                Container(
                                  width: 55.33,
                                  height: 55.33,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6F0FB),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Transform.rotate(
                                      angle: -0.19 * (3.14159265359 / 180), // Convert to radians
                                      child: Image.asset(
                                        cartItem.product.imageUrl,
                                        width: 26.98,
                                        height: 36.88,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.medication, size: 24);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Product details
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Price
                                        Text(
                                          formatCurrency(cartItem.product.price),
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1,
                                            color: Color(0xFF0085FF),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Product name
                                        Text(
                                          cartItem.product.name,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1,
                                            color: Color(0xFF2D2D2D),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                // Quantity controls
                                Container(
                                  width: 30,
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Increment button
                                      InkWell(
                                        onTap: () {
                                          cartProvider.incrementQuantity(cartItem.product.id);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: const Color(0xFF0085FF),
                                          size: 20,
                                        ),
                                      ),
                                      // Quantity display
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Text(
                                          '${cartItem.quantity}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      // Decrement button
                                      InkWell(
                                        onTap: () {
                                          cartProvider.decrementQuantity(cartItem.product.id);
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: const Color(0xFF0085FF),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Order summary container
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Order summary items
                  _buildSummaryRow('Saved on Order', formatCurrency(cartProvider.savedOnOrder)),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Cash Back', formatCurrency(cartProvider.cashBack)),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Subtotal', formatCurrency(cartProvider.subtotal)),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Shipping Charges', formatCurrency(cartProvider.shippingCharges)),
                  
                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        formatCurrency(cartProvider.total),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  
                  // Checkout button
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Checkout functionality
                        // This would be implemented in a real app
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Proceeding to checkout...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0085FF),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Check out',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
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
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF868889),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF868889),
          ),
        ),
      ],
    );
  }
}