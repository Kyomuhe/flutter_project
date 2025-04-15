import 'package:flutter/material.dart';
import 'rating_widget.dart';
import 'patient_info_screen.dart';

// The modified HomeCareScreen with tappable practitioners
class HomeCareScreen extends StatelessWidget {
  const HomeCareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF61CEFFB8), Colors.transparent, Color(0xFF61CEFFB8)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
                    children: [
                      PractitionerCard(
                        name: 'Abaasa Hellon',
                        role: 'Midwife',
                        rating: 4,
                        years: 6,
                        image: 'prac1.png',
                        onTap: () => _navigateToProfile(context, 'H. Abaasta Hellon', 'Female : 33 years', 4, 
                        'General Nurse (6 years in this specialty)', 'Jefu Medical Hospital', 
                        'Specializes in treating the skin, hair, and nails.', 'prac1.png'),
                      ),
                      PractitionerCard(
                        name: 'Wafula Hassan',
                        role: 'Midwife',
                        rating: 4,
                        years: 6,
                        image: 'prac2.png',
                        onTap: () => _navigateToProfile(context, 'Wafula Hassan', 'Male : 29 years', 4, 
                        'General Nurse (6 years in this specialty)', 'Central Hospital', 
                        'Specializes in maternal health and childbirth.', 'prac2.png'),
                      ),
                      PractitionerCard(
                        name: 'Tumusiime Hellon',
                        role: 'Midwife',
                        rating: 3,
                        years: 6,
                        image: 'prac3.png',
                        onTap: () => _navigateToProfile(context, 'T. Tumusiime Hellon', 'Female : 31 years', 3, 
                        'General Nurse (6 years in this specialty)', 'Community Health Center', 
                        'Specializes in prenatal and postnatal care.', 'prac3.png'),
                      ),
                      PractitionerCard(
                        name: 'Faheema Agasha',
                        role: 'Midwife',
                        rating: 4,
                        years: 6,
                        image: 'prac4.png',
                        onTap: () => _navigateToProfile(context, 'F. Faheema Agasha', 'Male : 35 years', 4, 
                        'General Nurse (6 years in this specialty)', 'Regional Medical Center', 
                        'Specializes in family health and wellness care.', 'prac4.png'),
                      ),
                      PractitionerCard(
                        name: 'Asiimwe Ritaj k',
                        role: 'Midwife',
                        rating: 5,
                        years: 5,
                        image: 'profile5.png',
                        onTap: () => _navigateToProfile(context, 'A. Asiimwe Ritaj', 'Female : 28 years', 5, 
                        'General Nurse (5 years in this specialty)', 'Urban Health Clinic', 
                        'Specializes in women\'s health and reproductive care.', 'profile5.png'),
                      ),
                      PractitionerCard(
                        name: 'Abaasa Hellon',
                        role: 'Midwife',
                        rating: 5,
                        years: 6,
                        image: 'profile6.png',
                        onTap: () => _navigateToProfile(context, 'H. Abaasa Hellon', 'Male : 34 years', 5, 
                        'General Nurse (6 years in this specialty)', 'Premier Medical Center', 
                        'Specializes in pediatric and maternal care.', 'profile6.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context, String name, String demographics, 
      int rating, String specialty, String hospital, String about, String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PractitionerProfileScreen(
          name: name,
          demographics: demographics,
          rating: rating,
          specialty: specialty,
          hospital: hospital,
          about: about,
          image: image,
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
  final VoidCallback onTap;

  const PractitionerCard({
    Key? key,
    required this.name,
    required this.role,
    required this.rating,
    required this.years,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile image (tappable)
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 84,
            height: 83,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/$image'),
                fit: BoxFit.cover,
              ),
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

// New Profile Screen
class PractitionerProfileScreen extends StatelessWidget {
  final String name;
  final String demographics;
  final int rating;
  final String specialty;
  final String hospital;
  final String about;
  final String image;

  const PractitionerProfileScreen({
    Key? key,
    required this.name,
    required this.demographics,
    required this.rating,
    required this.specialty,
    required this.hospital,
    required this.about,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF61CEFFB8), Colors.transparent, Color(0xFF61CEFFB8)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              
              // Profile content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Profile image with blue border
                      Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0x4D0085FF), // #0085FF4D (30% opacity)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xCC18A0FB), // #18A0FBCC (80% opacity)
                                width: 10,
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/$image'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Name
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Demographics
                      Text(
                        demographics,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Rating
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                size: 24,
                                color: index < rating ? Colors.amber : Colors.grey[300],
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '6 of 10 Ratings',
                            style: TextStyle(
                              color: Colors.grey, 
                              fontSize: 11,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Specialty
                      Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Hospital
                      Text(
                        hospital,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // About
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About:', 
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              about,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Buttons
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: Colors.blue.shade300),
                                  ),
                                ),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  PatientInfoScreen()),
                                          );

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}