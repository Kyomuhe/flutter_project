import 'package:flutter/material.dart';
import '../Components/image_swipper.dart';
import '../Components/category_icons.dart';
import '../Components/images_Page.dart';
import '../Pages/products_page.dart';
import '../Components/shop_categories.dart';
import '../Components/order_card.dart';
import '../Components/expert.dart';
import 'package:provider/provider.dart';
import '../Components/cart.dart';
import 'patient_appointments.dart';
import 'products_page.dart';
import 'profile.dart';
import '../Components/side_menu_drawer.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // List of pages for the bottom navigation
  final List<Widget> _pages = [
    const HomeContent(),
    const PatientAppointments(),
    const FeatureNotImplemented(featureName: "Messages"),
    const FeatureNotImplemented(featureName: "Notifications"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenuDrawer(), 
      body: _pages[_selectedIndex], 
      bottomNavigationBar: Container(
        height: 70, 
        decoration: const BoxDecoration(
          color: Color(0xFF0085FF),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'home1.png', 'Home'),
              _buildNavItem(1, 'records.png', 'E-Records'),
              _buildNavItem(2, 'messages.png', 'Messages'),
              _buildNavItem(3, 'bell.png', 'Notification'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String imageName, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/$imageName',
            width: 24,
            height: 24,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
          ),
          const SizedBox(height: 4),
          Container(
            height: 15, 
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder widget for features not yet implemented
class FeatureNotImplemented extends StatelessWidget {
  final String featureName;
  
  const FeatureNotImplemented({Key? key, required this.featureName}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 80,
              color: Color(0xFF0085FF),
            ),
            const SizedBox(height: 20),
            Text(
              "$featureName Feature",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0085FF),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "This feature is not yet implemented.\nWe'll be adding it soon!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImages = [
      'assets/swipper1.png',
      'assets/swiper2.PNG',
      'assets/swiper3.PNG',
      'assets/swiper4.PNG',
      'assets/swipper1.png',
    ];

    return Container(
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
            children: [
              // App bar / header
              Container(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset(
                                'assets/home.png',
                                width: 20,
                                height: 18,
                              ),
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
                        const Text(
                          "Hello, Abaasa.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x12000000),
                                  offset: Offset(0, 6),
                                  blurRadius: 14,
                                ),
                              ],
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Search for Medicines",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(Icons.search, color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.6,
                              ),
                              image: const DecorationImage(
                                image: AssetImage('assets/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: CategoryIcons(),
              ),
              const SizedBox(height: 24),
              const ShopByConditionComponent(),
              const SizedBox(height: 24),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, 
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return ProductPage();
                  }
                ),
              ),

              //order card
              PrescriptionOrderCard(
                leftImagePath: 'assets/rx.png',
                uploadIconPath: 'assets/Vector.png',
                onUploadPressed: () {
                  print('Upload button pressed');
                },
              ),
              const SizedBox(height: 24),

              const ShopCategoriesWidget(),
              const SizedBox(height: 24),

              //expert
              NCareExpertContact(
                expertImagePath: 'assets/profile1.png',
                callIconPath: 'assets/call.png',
                chatIconPath: 'assets/chat.png',
                onCallPressed: () {
                // Handle call button press
                  print('Call button pressed');
                },
                onChatPressed: () {
                // Handle chat button press
                  print('Chat button pressed');
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}