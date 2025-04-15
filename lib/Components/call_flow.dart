import 'package:flutter/material.dart';

class CallFlow extends StatefulWidget {
  const CallFlow({Key? key}) : super(key: key);

  @override
  State<CallFlow> createState() => _CallFlowState();
}

class _CallFlowState extends State<CallFlow> {
  CallState _callState = CallState.ringing;
  
  @override
  void initState() {
    super.initState();
    // Auto transition from ringing to connected after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _callState = CallState.connected;
        });
      }
    });
  }

  void _enableVideo() {
    setState(() {
      _callState = CallState.video;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_callState) {
      case CallState.ringing:
        return RingingScreen(doctor: mockDoctor);
      case CallState.connected:
        return ConnectedScreen(
          doctor: mockDoctor,
          duration: "00:00:30",
          onEnableVideo: _enableVideo,
        );
      case CallState.video:
        return VideoCallScreen(
          doctor: mockDoctor,
          patient: mockPatient,
        );
    }
  }
}

enum CallState { ringing, connected, video }

// Mock data
final Doctor mockDoctor = Doctor(
  name: "Dr. Hassan Wafula",
  specialization: "Dermatologist",
  profileImage: "assets/doctor.PNG",
  screenImage: "assets/prac4.png",
);

final Patient mockPatient = Patient(
  name: "Fatima Ahmed",
  profileImage: "assets/patient.png",
);

class Doctor {
  final String name;
  final String specialization;
  final String profileImage;
  final String screenImage;

  Doctor({
    required this.name,
    required this.specialization,
    required this.profileImage,
    required this.screenImage,
  });
}

class Patient {
  final String name;
  final String profileImage;

  Patient({
    required this.name,
    required this.profileImage,
  });
}

// Screen 1: Ringing Screen
class RingingScreen extends StatelessWidget {
  final Doctor doctor;

  const RingingScreen({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Doctor profile image
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: Image.asset(
                            doctor.screenImage,
                            errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 60, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Doctor name
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // Specialization
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Ringing text
                      const Text(
                        "Ringing...",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Timer
                      const Text(
                        "00:00:00",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Call control buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // End call button (red with white icon)
                    CallButton(
                      icon: Icons.call_end,
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      size: 55,
                      onPressed: () => Navigator.of(context).pop(),
                      label: "End call",
                      showLabel: true,
                    ),
                    // Video off button
                    CallButton(
                      icon: Icons.videocam_off,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: () {},
                      label: "Enable video",
                      showLabel: true,
                    ),
                    // Mute button
                    CallButton(
                      icon: Icons.mic,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: () {},
                      label: "Mute",
                      showLabel: true,
                    ),
                    // More button
                    CallButton(
                      icon: Icons.more_horiz,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: () {},
                      label: "More",
                      showLabel: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 2: Connected Audio Call Screen
class ConnectedScreen extends StatelessWidget {
  final Doctor doctor;
  final String duration;
  final VoidCallback onEnableVideo;

  const ConnectedScreen({
    Key? key,
    required this.doctor,
    required this.duration,
    required this.onEnableVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Doctor profile image
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: Image.asset(
                            doctor.screenImage,
                            errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 60, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Doctor name
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // Specialization
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Connected text
                      const Text(
                        "Connected",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Timer
                      Text(
                        duration,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Call control buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CallButton(
                      icon: Icons.call_end,
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      size: 55,
                      onPressed: () => Navigator.of(context).pop(),
                      label: "End call",
                      showLabel: true,
                    ),
                    // Video off button 
                    CallButton(
                      icon: Icons.videocam_off,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: onEnableVideo,
                      label: "Enable video",
                      showLabel: true,
                    ),
                    // Mute button
                    CallButton(
                      icon: Icons.mic,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: () {},
                      label: "Mute",
                      showLabel: true,
                    ),
                    // More button
                    CallButton(
                      icon: Icons.more_horiz,
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                      size: 55,
                      onPressed: () {},
                      label: "More",
                      showLabel: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 3: Video Call Screen
class VideoCallScreen extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;

  const VideoCallScreen({
    Key? key,
    required this.doctor,
    required this.patient,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  // Position for draggable self-view
  Offset selfViewPosition = const Offset(20, 70);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selfViewSize = Size(size.width * 0.3, size.width * 0.3 * 4/3);
    
    return Scaffold(
      body: Stack(
        children: [
          // Main video (doctor) - Full screen image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              widget.doctor.profileImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[800],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.doctor.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Draggable self-view (patient) - Full image coverage
          Positioned(
            left: selfViewPosition.dx,
            top: selfViewPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  selfViewPosition = Offset(
                    selfViewPosition.dx + details.delta.dx,
                    selfViewPosition.dy + details.delta.dy,
                  );
                  
                  // Keep within screen bounds
                  if (selfViewPosition.dx < 0) selfViewPosition = Offset(0, selfViewPosition.dy);
                  if (selfViewPosition.dy < 50) selfViewPosition = Offset(selfViewPosition.dx, 50);
                  if (selfViewPosition.dx > size.width - selfViewSize.width) {
                    selfViewPosition = Offset(size.width - selfViewSize.width, selfViewPosition.dy);
                  }
                  if (selfViewPosition.dy > size.height - selfViewSize.height - 100) {
                    selfViewPosition = Offset(selfViewPosition.dx, size.height - selfViewSize.height - 100);
                  }
                });
              },
              child: Container(
                width: selfViewSize.width,
                height: selfViewSize.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.patient.profileImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.person, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Call control buttons
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // End call button (red with white icon)
                CallButton(
                  icon: Icons.call_end,
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  size: 55,
                  onPressed: () => Navigator.of(context).pop(),
                  label: "End call",
                  showLabel: false,
                ),
                // Video button (white)
                CallButton(
                  icon: Icons.videocam,
                  backgroundColor: Colors.white,
                  iconColor: Colors.black,
                  size: 55,
                  onPressed: () {},
                  label: "Video",
                  showLabel: false,
                ),
                // Mute button (white)
                CallButton(
                  icon: Icons.mic,
                  backgroundColor: Colors.white,
                  iconColor: Colors.black,
                  size: 55,
                  onPressed: () {},
                  label: "Mute",
                  showLabel: false,
                ),
                // More button (white)
                CallButton(
                  icon: Icons.more_horiz,
                  backgroundColor: Colors.white,
                  iconColor: Colors.black,
                  size: 55,
                  onPressed: () {},
                  label: "More",
                  showLabel: false,
                ),
              ],
            ),
          ),

          // Connected status bar - Now positioned below the icons with white background
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(widget.doctor.profileImage),
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(widget.patient.profileImage),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Connected",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "00:05:23",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Status bar with time
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Text(
                  "9:41",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Updated call button widget
class CallButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;
  final String label;
  final bool showLabel;

  const CallButton({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    this.iconColor = Colors.white,
    this.size = 50,
    required this.onPressed,
    required this.label,
    this.showLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: size * 0.5,
            ),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ],
    );
  }
}