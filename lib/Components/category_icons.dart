import 'package:flutter/material.dart';
import 'doctor_profile.dart'; 
import 'home_care.dart';

class CategoryIcons extends StatefulWidget {
  const CategoryIcons({Key? key}) : super(key: key);

  @override
  State<CategoryIcons> createState() => _CategoryIconsState();
}

class _CategoryIconsState extends State<CategoryIcons> {
  // Track the selected category index (0 for Doctor by default)
  int _selectedIndex = 0;

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

  void _navigateToPage(BuildContext context, int index) {
    Widget page;
    
    // Determine which page to navigate to based on the index
    switch (index) {
      case 0: // Doctor
        page = const DoctorPage();
        break;
      case 2: // Hospital (index 2)
        page = const HomeCareScreen();
        break;
      default:
        // For other categories, show a placeholder or message for now
        page = Scaffold(
          appBar: AppBar(title: Text(_categories[index]['label'])),
          body: Center(
            child: Text("${_categories[index]['label']} page will be implemented soon."),
          ),
        );
    }
    
    // Navigate to the selected page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 291,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_categories.length, (index) {
          // Check if this category is selected
          bool isSelected = index == _selectedIndex;
          // Check if this is the Doctor category (index 0)
          bool isDoctor = index == 0;
          
          return InkWell(
            onTap: () {
              // Update the selected index
              setState(() {
                _selectedIndex = index;
              });
              
              // Navigate to the appropriate page based on the selected index
              _navigateToPage(context, index);
            },
            borderRadius: BorderRadius.circular(20),
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
                        color: const Color(0x33000000), // #00000033 - 20% opacity
                        blurRadius: 25,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isDoctor 
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            isSelected ? Colors.white : const Color(0xFF0085FF),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            _categories[index]['icon'],
                            width: 38,
                            height: 34,
                          ),
                        )
                      : Image.asset(
                          _categories[index]['icon'],
                          width: 38,
                          height: 34,
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