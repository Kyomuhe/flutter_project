import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ShopByConditionComponent extends StatelessWidget {
  const ShopByConditionComponent({Key? key}) : super(key: key);

  static final List<Map<String, String>> conditionItems = [
    {'image': 'assets/diabetes.png', 'label': 'Diabetes'},
    {'image': 'assets/condition.png', 'label': 'Heart Care'},
    {'image': 'assets/precious.png', 'label': 'Intestines'},
    {'image': 'assets/care.png', 'label': 'Face Care'},
    {'image': 'assets/joint.png', 'label': 'Joint Pain'},
    {'image': 'assets/diabetes.png', 'label': 'Diabetes'},
    {'image': 'assets/condition.png', 'label': 'Heart Care'},
    {'image': 'assets/precious.png', 'label': 'Intestines'},
    {'image': 'assets/care.png', 'label': 'Face Care'},
    {'image': 'assets/joint.png', 'label': 'Joint Pain'},
  ];

  @override
  Widget build(BuildContext context) {
    // Only display the first 5 items in the main view
    final displayItems = conditionItems.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header container with "Shop by condition" and "Explore all"
        Container(
          width: 344,
          height: 32,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "Shop by condition" text
              const Text(
                'Shop by condition',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              
              // "Explore all" text - clickable and navigates to grid view
              GestureDetector(
                onTap: () {
                  // Navigate to a new page with a grid view
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllConditionsPage(items: conditionItems),
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
        
        // Images with text below them
        SizedBox(
          height: 81,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayItems.length,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    // Image container
                    Container(
                      width: 64.74,
                      height: 65.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // Placeholder color - replace with your image
                        color: Colors.grey.shade300,
                        image: DecorationImage(
                          image: AssetImage(displayItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Text label below image
                    SizedBox(
                      width: 49,
                      height: 11,
                      child: Center(
                        child: Text(
                          displayItems[index]['label']!,
                          style: const TextStyle(
                            color: Color(0xFF41474C),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AllConditionsPage extends StatelessWidget {
  final List<Map<String, String>> items;

  const AllConditionsPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background with blur effects
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0x61CEFFB8), // Top left: #61CEFFB8 with fade
                  Color(0x0EBE7E4D), // Bottom right: #0EBE7E4D
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 121.0,
                sigmaY: 121.0,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'All conditions',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D), 
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Grid of conditions with 3 columns
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Changed from 2 to 3 columns
                        crossAxisSpacing: 12.0, // Slightly reduced spacing for 3 columns
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75, // Adjusted for 3 columns
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ConditionGridItem(
                          image: items[index]['image']!,
                          label: items[index]['label']!,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Individual grid item for the AllConditionsPage
class ConditionGridItem extends StatelessWidget {
  final String image;
  final String label;

  const ConditionGridItem({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image container
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Text label below image
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF41474C),
            fontSize: 12, // Slightly reduced for 3-column layout
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}