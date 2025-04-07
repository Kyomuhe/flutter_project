import 'package:flutter/material.dart';
import '../Components/image_swipper.dart';
import '../Components/category_icons.dart';
import '../Components/images_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Correct image paths with file extensions
    final List<String> bannerImages = [
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Custom app bar/header section
              Container(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
                color: Colors.white,
                child: Column(
                  children: [
                    // First row: Logo and greeting
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Row(
                          children: [
                            Image.asset(
                              'assets/home.png',
                              width: 20,
                              height: 18,
                            ),
                            const SizedBox(width: 8),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Next",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF0085FF),
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Doc",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF0085FF),
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Greeting text
                        const Text(
                          "Hello, Abaasa.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Second row: Search field and profile
                    Row(
                      children: [
                        // Search field
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for Medicines",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[400],
                                  fontSize: 14
                                ),
                                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Profile avatar
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 16,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Image Swiper
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: ImageSwiper(
                        imageUrls: bannerImages,
                        autoSwipe: true,
                        swipeIntervalSeconds: 3,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Category icons section
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: CategoryIcons(),
              ),

              // Add the ShopByConditionComponent here
              const ShopByConditionComponent(),
              
              // Add some bottom padding to prevent overflow with bottom navigation
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          backgroundColor: const Color(0xFF0085FF),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}