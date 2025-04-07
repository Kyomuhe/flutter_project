import 'package:flutter/material.dart';

class CategoryIcons extends StatefulWidget {
  const CategoryIcons({Key? key}) : super(key: key);

  @override
  State<CategoryIcons> createState() => _CategoryIconsState();
}

class _CategoryIconsState extends State<CategoryIcons> {
  final List<Map<String, dynamic>> _categories = [
    {
      'icon': 'assets/surgeon.png',
      'label': 'Doctor',
    },
    {
      'icon': 'assets/nurse.png',
      'label': 'Pharmacy',
    },
    {
      'icon': 'assets/lab.png',
      'label': 'Hospital',
    },
    {
      'icon': 'assets/cal.png',
      'label': 'Ambulance',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 291,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_categories.length, (index) {
          bool isFirstCard = index == 0;
          
          return InkWell(
            onTap: () {
              // Navigation will be implemented later
            },
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // Icon container
                Container(
                  width: 62.42,
                  height: 62.42,
                  decoration: BoxDecoration(
                    color: isFirstCard ? const Color(0xFF0085FF) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x33000000), // #00000033 - 20% opacity
                        blurRadius: 25,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      _categories[index]['icon'],
                      width: 38,
                      height: 34,
                      // No color tint applied to the images
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Label
                Text(
                  _categories[index]['label'],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isFirstCard ? const Color(0xFF0085FF) : Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}