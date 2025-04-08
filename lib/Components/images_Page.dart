import 'package:flutter/material.dart';

class ShopByConditionComponent extends StatefulWidget {
  const ShopByConditionComponent({Key? key}) : super(key: key);

  @override
  State<ShopByConditionComponent> createState() => _ShopByConditionComponentState();
}

class _ShopByConditionComponentState extends State<ShopByConditionComponent> {
  bool _showAllItems = false;

  // Sample data for demonstration - replace with your actual items
  final List<Map<String, String>> _conditionItems = [
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
    // Determine how many items to display based on _showAllItems flag
    final displayItems = _showAllItems 
        ? _conditionItems 
        : _conditionItems.take(5).toList();

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
              
              // "Explore all" text - clickable
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showAllItems = !_showAllItems;
                  });
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
                    Container(
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