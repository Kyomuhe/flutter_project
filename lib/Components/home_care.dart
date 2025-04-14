import 'package:flutter/material.dart';
import 'rating_widget.dart';

class HomeCareScreen extends StatelessWidget {
  const HomeCareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F2F7),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
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
                  const SizedBox(width: 16),
                  const Text(
                    'HomeCare practitioners',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 330,
              height: 45,
              margin: const EdgeInsets.only(top: 30, left: 22),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E6EB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.search,
                          color: Color(0xFF667085),
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by speciality',
                              hintStyle: TextStyle(
                                color: Color(0xFF667085),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
            // Practitioners grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                  children: const [
                    PractitionerCard(
                      name: 'Abaasa Hellon',
                      role: 'Midwife',
                      rating: 4,
                      years: 6,
                      image: 'profile1.png',
                    ),
                    PractitionerCard(
                      name: 'Wafula Hassan',
                      role: 'Midwife',
                      rating: 4,
                      years: 6,
                      image: 'profile2.png',
                    ),
                    PractitionerCard(
                      name: 'Tumusiime Hellon',
                      role: 'Midwife',
                      rating: 3,
                      years: 6,
                      image: 'profile3.png',
                    ),
                    PractitionerCard(
                      name: 'Faheema Agasha',
                      role: 'Midwife',
                      rating: 4,
                      years: 6,
                      image: 'profile4.png',
                    ),
                    PractitionerCard(
                      name: 'Asiimwe Ritaj k',
                      role: 'Midwife',
                      rating: 5,
                      years: 5,
                      image: 'profile5.png',
                    ),
                    PractitionerCard(
                      name: 'Abaasa Hellon',
                      role: 'Midwife',
                      rating: 5,
                      years: 6,
                      image: 'profile6.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PractitionerCard extends StatelessWidget {
  final String name;
  final String role;
  final int rating;
  final int years;
  final String image;

  const PractitionerCard({
    Key? key,
    required this.name,
    required this.role,
    required this.rating,
    required this.years,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/$image'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Name
        Text(
          name,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Role
        Text(
          role,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Rating and years
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingWidget(
              rating: rating,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              '$years yrs',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}