import 'package:flutter/material.dart';
import 'cart.dart';

// Notification service class
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  void showSuccessNotification(BuildContext context, String message) {
    if (_isVisible) {
      _overlayEntry?.remove();
      _isVisible = false;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => SuccessNotification(
        message: message,
        onDismiss: () {
          _overlayEntry?.remove();
          _isVisible = false;
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // Auto dismiss after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (_isVisible) {
        _overlayEntry?.remove();
        _isVisible = false;
      }
    });
  }
}

// Success notification widget
class SuccessNotification extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const SuccessNotification({
    Key? key,
    required this.message,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<SuccessNotification> createState() => _SuccessNotificationState();
}

class _SuccessNotificationState extends State<SuccessNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0085FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Success',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF0085FF),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.message,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Progress indicator
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _animation.value,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0085FF)),
                    minHeight: 4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Floating Cart Button Widget
class FloatingCartButton extends StatelessWidget {
  final CartProvider cartProvider;
  final VoidCallback onTap;

  const FloatingCartButton({
    Key? key,
    required this.cartProvider,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF22C55E), 
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product images stack
            SizedBox(
              width: 60,
              height: 34,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: _buildProductImages(),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${cartProvider.itemCount} items',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              height: 34,
              width: 34,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProductImages() {
    final maxDisplayedImages = 3; // Maximum number of images to show
    final items = cartProvider.items;
    final itemsToShow = items.length > maxDisplayedImages ? maxDisplayedImages : items.length;
    
    List<Widget> imageWidgets = [];
    
    // Add product images with overlap effect
    for (int i = 0; i < itemsToShow; i++) {
      imageWidgets.add(
        Positioned(
          left: i * 20.0, // Overlap each image by positioning them
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                items[i].product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.medication, size: 20, color: Color(0xFF0085FF));
                },
              ),
            ),
          ),
        ),
      );
    }
    
    // Add indicator for more items if needed
    if (items.length > maxDisplayedImages) {
      imageWidgets.add(
        Positioned(
          left: maxDisplayedImages * 20.0,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0085FF).withOpacity(0.8),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                '+${items.length - maxDisplayedImages}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    // If cart is empty, show default cart icon
    if (imageWidgets.isEmpty) {
      imageWidgets.add(
        const Icon(Icons.shopping_cart_outlined, color: Colors.white)
      );
    }
    
    return imageWidgets;
  }
}