import 'package:flutter/material.dart';


class CategoryGridLayout extends StatelessWidget {
  const CategoryGridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FA),
appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      margin: const EdgeInsets.all(8.0), // Optional: add some spacing
      height: 36,
      width: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/icon.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
  title: const Text(
    'All Categories',
    style: TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: const [
            CategoryCard(
              title: "Must haves",
              iconColor: Color(0xFFEEDDFF),
              assetPath: "assets/cat1.png",
            ),
            CategoryCard(
              title: "Supplements",
              iconColor: Color(0xFFFFF6DD),
              assetPath: "assets/cat2.png",
            ),
            CategoryCard(
              title: "Sexual Health",
              iconColor: Color(0xFFDDFFF6),
              assetPath: "assets/cat3.png",
            ),
            CategoryCard(
              title: "Sexual Health",
              iconColor: Color(0xFFDDFFF6),
              assetPath: "assets/cat4.png",
            ),
            CategoryCard(
              title: "Baby care",
              iconColor: Color(0xFFDDEEFF),
              assetPath: "assets/cat5.png",
            ),
            CategoryCard(
              title: "Pain Relief",
              iconColor: Color(0xFFFFDDEE),
              assetPath: "assets/cat1.png",
            ),
            CategoryCard(
              title: "Must haves",
              iconColor: Color(0xFFEEDDFF),
              assetPath: "assets/cat2.png",
            ),
            CategoryCard(
              title: "Sexual Health",
              iconColor: Color(0xFFDDFFF6),
              assetPath: "assets/cat4.png",
            ),
            CategoryCard(
              title: "Must haves",
              iconColor: Color(0xFFEEDDFF),
              assetPath: "assets/cat5.png",
            ),
            CategoryCard(
              title: "Supplements",
              iconColor: Color(0xFFDDFFF6),
              assetPath: "assets/cat4.png",
            ),
            CategoryCard(
              title: "Sexual health",
              iconColor: Color(0xFFDDEEFF),
              assetPath: "assets/cat5.png",
            ),
            CategoryCard(
              title: "Pain Relief",
              iconColor: Color(0xFFFFDDEE),
              assetPath: "assets/cat1.png",
            ),
            CategoryCard(
              title: "Multi Boxes",
              iconColor: Color(0xFFEEDDFF),
              assetPath: "assets/cat2.png",
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final Color iconColor;
  final String assetPath;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconColor,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38.5,
            height: 38.5,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                assetPath,
                width: 18.14,
                height: 19.76,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 12,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF868889),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 8,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}