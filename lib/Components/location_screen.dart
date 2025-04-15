// screens/location_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_registration_model.dart';
import '../widgets/progress_indicator.dart';
import 'scedule_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedLocation = 'Lumumba Avenue';
  String _fullAddress = '6360 Lumumba ave, Kampala';
  bool _useCurrentLocation = false;
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PatientRegistrationModel>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    SizedBox(width:10),
                  Text(
                    'Patients current location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Share patient\'s current location, you can use your location if with patient.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Search location
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Start searching location',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Colors.white,
                        filled: true,

                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Use current location
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _useCurrentLocation = true;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.my_location),
                          SizedBox(width: 8),
                          Text('Use your current location'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 16),
                    
                    // Search result
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEARCH RESULT',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _selectedLocation,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _fullAddress,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    model.setLocationInfo(
                      locationName: _selectedLocation,
                      address: _fullAddress,
                    );
                    model.nextStep();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Continue'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              StepProgressIndicator(currentStep: model.currentStep, totalSteps: 4),
            ],
          ),
        ),
      ),
    );
  }
}