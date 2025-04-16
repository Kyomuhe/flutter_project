import 'package:flutter/material.dart';

class PatientAppointments extends StatelessWidget {
  const PatientAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'poppins',
        scaffoldBackgroundColor: const Color(0xFFF0F9F9),
      ),
      home: const AppointmentsScreen(),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String selectedTab = 'All';
  List<String> tabs = ['All', 'Active', 'Finished'];

  List<AppointmentModel> allAppointments = [
    AppointmentModel(
      doctorName: 'Dr. Abaasa Hellon',
      specialization: 'Dermatologist',
      date: '13th June 2024',
      time: '18:35pm',
      duration: '02:31',
      status: 'finished',
      rating: 4,
      hasCancellationOption: false,
    ),
    AppointmentModel(
      doctorName: 'Dr. Abaasa Hellon',
      specialization: 'Dermatologist',
      date: '13th June 2025',
      time: '18:35pm',
      duration: '04:31',
      status: 'active',
      hasCancellationOption: true,
    ),
    AppointmentModel(
      doctorName: 'Dr. Abaasa Hellon',
      specialization: 'Dermatologist',
      date: '13th June 2025',
      time: '18:35pm',
      duration: '04:31',
      status: 'active',
      hasCancellationOption: true,
    ),
  ];

  List<AppointmentModel> get filteredAppointments {
    if (selectedTab == 'All') return allAppointments;
    return allAppointments.where((apt) => apt.status.toLowerCase() == selectedTab.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFEEEEEE),
                    radius: 18,
                    child: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
            
            // Blue info card - Modified to place "3" above "Pending"
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Abaasa,',
                          style: TextStyle(
                            color: Color(0xFFDDD9D9),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Easily manage appointments',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today, color: Colors.blue, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'Aug 08, 3:00pm',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Modified to place "3" above "Pending"
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Tab selector
            Container(
              margin: const EdgeInsets.all(16),
              height: 40,
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab == tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE5EBFC) : Colors.transparent,
                          border: isSelected 
                            ? Border.all(color: Colors.blue, width: 1.5)
                            : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            tab,
                            style: TextStyle(
                              color: isSelected ? Colors.blue : Colors.grey,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Appointment list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = filteredAppointments[index];
                  return UpdatedAppointmentCard(
                    appointment: appointment,
                    onCancelTap: () {
                      // Navigate to full page cancellation screen instead of showing bottom sheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CancellationReasonPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
            // Bottom button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Make an appointment now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatedAppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback onCancelTap;

  const UpdatedAppointmentCard({
    super.key,
    required this.appointment,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9D9D9), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor info column with image on top - RESTRUCTURED
          Column(
            children: [
              // Doctor image - Using asset image
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/profile.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              
              // Doctor info below profile picture
              SizedBox(
                width: 100, // Adjust width as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF2D2D2D),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      appointment.specialization,
                      style: const TextStyle(
                        color: Color(0xFF677294),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (appointment.status == 'finished' && appointment.rating != null)
                      Row(
                        children: [
                          Text(
                            'Rate ',
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 12,
                            ),
                          ),
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 12,
                              color: index < (appointment.rating ?? 0) ? Colors.amber : Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    // Add Cancel Appointment option for active appointments
                    if (appointment.hasCancellationOption)
                      TextButton(
                        onPressed: onCancelTap,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Right column with time and action button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Time display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  appointment.duration,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              
              // Time info
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    appointment.time,
                    style: const TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              
              // Date info
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    appointment.date,
                    style: const TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Action button 
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  appointment.status == 'finished' ? 'Schedule again' : 'Reschedule',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Full page cancellation with updated radio buttons design
class CancellationReasonPage extends StatefulWidget {
  const CancellationReasonPage({super.key});

  @override
  State<CancellationReasonPage> createState() => _CancellationReasonPageState();
}

class _CancellationReasonPageState extends State<CancellationReasonPage> {
  String? selectedReason;
  final List<String> reasons = [
    'Weather conditions',
    'Un expected work',
    'Weather conditions',
    'Others'
  ];
  final TextEditingController otherReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Color(0xFFEEEEEE),
            radius: 18,
            child: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Appointments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s know the main reason why your cancelling this appointment.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            
            // Reason options - updated to match design
            Column(
              children: reasons.asMap().entries.map((entry) {
                final reason = entry.value;
                final bool isSelected = selectedReason == reason;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedReason = reason;
                      });
                    },
                    child: Row(
                      children: [
                        // Updated radio button design
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.blue : const Color(0xFFD9D9D9),
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          reason,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            // Other reason text field - updated styling
            if (selectedReason == 'Others')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    TextField(
                      controller: otherReasonController,
                      decoration: const InputDecoration(
                        hintText: 'Other reasons, specify',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            
            const Spacer(),
            
            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm & Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentModel {
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String duration;
  final String status;
  final int? rating;
  final bool hasCancellationOption;

  AppointmentModel({
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.duration,
    required this.status,
    this.rating,
    required this.hasCancellationOption,
  });
}