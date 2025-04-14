import 'package:flutter/material.dart';
import 'rating_widget.dart'; // Import the rating widget
import 'doctor_details.dart'; // Import the doctor details page

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    const SizedBox(width: 20),
                    Container(
                      height: 18,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Medical Practitioners',
                        style: TextStyle(
                          fontFamily: 'GT Walsheim Pro',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          height: 0.9, // to achieve line height of 18px
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF61CEFF).withOpacity(0.5), // Lighter blue
                    Colors.white.withOpacity(0.95),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.3, 0.5], // Smoother transition
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  
                  // Doctor close-by text
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 22),
                    child: const Text(
                      'Doctor close-by',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Doctor profiles list
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        DoctorProfileCard(
                          name: 'Dr. Sarah Johnson',
                          rating: 5,
                          maxRating: 10,
                          reviewCount: 125,
                          hospital: 'Mayo Clinic Hospital',
                          speciality: 'Cardiologist',
                          imageIndex: 1,
                          gender: 'Female',
                          age: 38,
                          patients: 1500,
                          experience: 12,
                        ),
                        DoctorProfileCard(
                          name: 'Dr. Michael Chen',
                          rating: 4,
                          maxRating: 10,
                          reviewCount: 98,
                          hospital: 'Cleveland Clinic',
                          speciality: 'Neurologist',
                          imageIndex: 2,
                          gender: 'Male',
                          age: 45,
                          patients: 1200,
                          experience: 15,
                        ),
                        DoctorProfileCard(
                          name: 'Dr. Emily Rodriguez',
                          rating: 5,
                          maxRating: 10,
                          reviewCount: 156,
                          hospital: 'Johns Hopkins Hospital',
                          speciality: 'Pediatrician',
                          imageIndex: 3,
                          gender: 'Female',
                          age: 33,
                          patients: 1800,
                          experience: 8,
                        ),
                        DoctorProfileCard(
                          name: 'Dr. James Wilson',
                          rating: 4,
                          maxRating: 10,
                          reviewCount: 87,
                          hospital: 'Mass General Hospital',
                          speciality: 'Dermatologist',
                          imageIndex: 4,
                          gender: 'Male',
                          age: 41,
                          patients: 950,
                          experience: 10,
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
    );
  }
}

class DoctorProfileCard extends StatelessWidget {
  final String name;
  final int rating;
  final int maxRating;
  final int reviewCount;
  final String hospital;
  final String speciality;
  final int imageIndex;
  final String gender;
  final int age;
  final int patients;
  final int experience;

  const DoctorProfileCard({
    Key? key,
    required this.name,
    required this.rating,
    required this.maxRating,
    required this.reviewCount,
    required this.hospital,
    required this.speciality,
    required this.imageIndex,
    required this.gender,
    required this.age,
    required this.patients,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 22, right: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor image - now clickable to navigate to details
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsPage(
                    name: name,
                    speciality: speciality,
                    hospital: hospital,
                    gender: gender,
                    age: age,
                    patients: patients,
                    experience: experience,
                    rating: rating,
                    imageIndex: imageIndex,
                  ),
                ),
              );
            },
            child: Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/profile$imageIndex.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Prevents overflow
              children: [
                // Doctor name
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                // Rating and reviews
                Row(
                  children: [
                    RatingWidget(
                      rating: rating,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$rating of $maxRating ratings',
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Hospital
                Text(
                  hospital,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
                const SizedBox(height: 2),
                // Speciality
                Text(
                  speciality,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
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