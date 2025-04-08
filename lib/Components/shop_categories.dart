import 'package:flutter/material.dart';

class ShopCategoriesWidget extends StatelessWidget {
  const ShopCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Top container with Shop by categories and Explore all
        SizedBox(
          width: 344,
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Left text - Shop by categories
              Container(
                height: 30,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: const Text(
                  'Shop by categories',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 30 / 16, // lineHeight / fontSize
                    letterSpacing: -0.21,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
              ),
              
              // Right text - Explore all
              Container(
                width: 58,
                height: 23,
                alignment: Alignment.center,
                child: const Text(
                  'Explore all',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 30 / 12, // lineHeight / fontSize
                    letterSpacing: -0.21,
                    color: const Color(0xFF0085FF),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Spacing between containers
        const SizedBox(height: 10),
        
        // Bottom container with circular cards
        SizedBox(
          width: 380.6,
          height: 65.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      width: 47.16,
                      height: 47.25,
                      child: Image.asset(
                        'assets/category${index + 1}.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}