import 'package:flutter/material.dart';

class CategoryIcons extends StatefulWidget {
  const CategoryIcons({Key? key}) : super(key: key);

  @override
  State<CategoryIcons> createState() => _CategoryIconsState();
}

class _CategoryIconsState extends State<CategoryIcons> {
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': 'Doctor.png',
      'label': 'Doctor',
    },
    {
      'icon': 'nurse.png',
      'label': 'Pharmacys',
    },
    {
      'icon': 'lab.png',
      'label': 'Hospital',
    },
    {
      'icon': 'app.png',
      'label': 'Ambulance',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 291,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_categories.length, (index) {
          bool isSelected = index == _selectedCategoryIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Column(
              children: [
                // Icon container
                Container(
                  width: 62.42,
                  height: 62.42,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0085FF) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      _categories[index]['icon'],
                      width: 38,
                      height: 34,
                      color: isSelected ? Colors.white : Colors.grey[600],
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
                    color: isSelected ? const Color(0xFF0085FF) : Colors.grey[600],
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