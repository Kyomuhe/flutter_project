import 'package:flutter/material.dart';

class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String speciality;
  final String hospital;
  final String gender;
  final int age;
  final int patients;
  final int experience;
  final int rating;
  final int imageIndex;

  const DoctorDetailsPage({
    Key? key,
    required this.name,
    required this.speciality,
    required this.hospital,
    required this.gender,
    required this.age,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.imageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top blue area
          SizedBox(
            height: 200,
            child: Container(
              width: double.infinity,
              color: const Color(0xFF0085FF),
              child: SafeArea(
                bottom: false,
                child: Stack(
                  clipBehavior: Clip.none, // Allow children to overflow
                  children: [
                    // Back button
                    Positioned(
                      top: 71 - MediaQuery.of(context).padding.top,
                      left: 33,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 43,
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/left.png',
                              width: 17,
                              height: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Details text
                    Positioned(
                      top: 82 - MediaQuery.of(context).padding.top,
                      left: 156,
                      child: const SizedBox(
                        width: 61,
                        height: 23,
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',

                          ),
                        ),
                      ),
                    ),
                    
                    // Chain icon button
                    Positioned(
                      top: 71 - MediaQuery.of(context).padding.top,
                      right: 33,
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/chain.png',
                          ),
                        ),
                      ),
                    ),
                    
                    // Doctor profile card with white background and blue border
                    Positioned(
                      top: 144,
                      left: 34,
                      child: Container(
                        width: 308,
                        height: 107,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                            color: const Color(0xFF0085FF),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Doctor profile image
                              Container(
                                width: 73,
                                height: 74,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  image: DecorationImage(
                                    image: AssetImage('assets/profile$imageIndex.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Doctor info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Doctor name
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: Color(0xFF2C2A2A),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: 'Poppins',

                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    // Speciality and hospital
                                    Text(
                                      '$speciality in $hospital',
                                      style: const TextStyle(
                                        color: Color(0xFF667085),
                                        fontSize: 11,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    // Gender and age
                                    Text(
                                      '$gender: $age years',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Content after the blue area - increased height to fix overflow
          const SizedBox(height: 75),
          
          // Stats section (Patients, Experience, Rating)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Patients', patients.toString()),
                _buildStatCard('Exp', '$experience Yr'),
                _buildStatCard('Rating', rating.toString()),
              ],
            ),
          ),
          
          // About section
          Padding(
            padding: const EdgeInsets.only(left: 34, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',

                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'MBBS, Ph.D, Fellow, International College of Surgeons.',
                  style: TextStyle(
                    color: Color(0xFF393737),
                    fontSize: 14,
                    fontFamily: 'Poppins',

                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ex- Professor & Head of Department\nDepartment of Neurosurgery\nDhaka Medical College & Hospital',
                  style: TextStyle(
                    color: Color(0xFF393737),
                    fontSize: 14,
                    fontFamily: 'Poppins',

                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Chat and Call buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF0085FF),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          color: Color(0xFF0085FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF0085FF),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Call',
                        style: TextStyle(
                          color: Color(0xFF0085FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Make an Appointment button
          Container(
            height: 47.5,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0085FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Text(
                'Make an Appointment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String label, String value) {
    return Container(
      width: 91,
      height: 87,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EAEB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label on top
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0085FF),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          // Value below
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF2B2A2A),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}