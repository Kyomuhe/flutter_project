import 'package:flutter/material.dart';
import 'dart:math' as math;

class Appointment extends StatelessWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const DoctorProfileScreen(),
    );
  }
}

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  int selectedDateIndex = 2; // Tuesday (index 2) is selected by default
  int selectedTimeIndex = 1; // 12:00 AM is selected by default

  final List<String> days = ['7\nSun', '8\nMon', '9\nTue', '10\nWed', '11\nThu'];
  final List<String> times = ['11:00 AM', '12:00 AM', '01:00 AM', '02:00 AM', '03:00 AM', '04:00 AM', '05:00 AM', '06:00 AM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Top bar with back and menu buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.link, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Doctor profile circle with layers
              Container(
                width: 100,  // Outer container size
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 80,  // Inner container size
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/profile1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Doctor name and speciality
              const Text(
                'Dr. Nakigudde Shamim',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Cardiologist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,

                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Female : 33 years',
                style: TextStyle(
                  color: const Color(0xFFD9D9D9),
                  fontSize: 14,                
                  fontWeight: FontWeight.w300,

                ),          

              ),
              const SizedBox(height: 20),
              // Bottom white container for schedule
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height:20),
                           const Center(
                            child: Text(
                            'Make an appointment now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'poppins',
                            ),
                          ),
                          ),
                          const SizedBox(height: 20),
                          // Schedule section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Schedules',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'August',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.chevron_right, color: Colors.black54),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Date selection
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: days.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDateIndex = index;
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: selectedDateIndex == index ? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        days[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: selectedDateIndex == index ? Colors.white : const Color(0xFF263257),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Hours',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                              color: const Color(0xFF263257),

                            ),
                          ),
                          const SizedBox(height: 20),
                          // Time selection using GridView with fixed height
                          SizedBox(
                            height: 200, // Fixed height for the GridView
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: times.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 2.0,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTimeIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedTimeIndex == index ? Colors.blue : Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        times[index],
                                        style: TextStyle(
                                          color: selectedTimeIndex == index ? Colors.white : Colors.black,
                                          fontWeight: selectedTimeIndex == index ? FontWeight.bold : FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Book appointment button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentSuccessScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Make Appointment',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class AppointmentSuccessScreen extends StatelessWidget {
  const AppointmentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            // Success animation with check mark
            SizedBox(
              height: 160,
              width: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Main blue circle with checkmark
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset('verified-fill.png'),
                    ),
                  ),
                  // Scattered dots - position and size variations
                  Positioned(
                    left: 20,
                    top: 60,
                    child: _buildDot(5),
                  ),
                  Positioned(
                    right: 30,
                    top: 70,
                    child: _buildDot(6),
                  ),
                  Positioned(
                    left: 70,
                    top: 20,
                    child: _buildDot(8),
                  ),
                  Positioned(
                    right: 50,
                    bottom: 40,
                    child: _buildDot(7),
                  ),
                  Positioned(
                    left: 40,
                    bottom: 30,
                    child: _buildDot(6),
                  ),
                ],
              ),
            ),



 const SizedBox(height: 30),
            const Text(
              'Appointment success',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
              ),
            ),
            const SizedBox(height: 30),
            // Appointment details card
            Container(
              width: 300,
              padding: const EdgeInsets.all(20),

  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.blue, 
      width: 1,           
    ),
    borderRadius: BorderRadius.circular(20), 
  ),

                
                
              
              child: Column(
                children: [
                  const Text(
                    'You have successfully booked an appointment with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2D2D2D),
                      fontSize: 14,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Nakigudde Shamim',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: Colors.blue, size: 20),
                          const SizedBox(width: 5),
                          const Text(
                            'March 24, Year',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blue, size: 20),
                          const SizedBox(width: 5),
                          const Text(
                            '10:00 AM',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double cos(double angle) {
  return math.cos(angle);
}

double sin(double angle) {
  return math.sin(angle);

}

  Widget _buildDot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }

