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
    final List<String> bannerImages = [
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
      'assets/swipper1.png',
    ];

    return Scaffold(
      body: Container(
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
                          Container(
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