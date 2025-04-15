// screens/patient_info_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_registration_model.dart';
import '../widgets/progress_indicator.dart';
import 'medical_info_screen.dart';

class PatientInfoScreen extends StatefulWidget {
  @override
  _PatientInfoScreenState createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _selectedGender = 'Male';
  DateTime? _selectedDate;
  String _countryCode = '+256';
  
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
                    'Patients information',
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
                'Whether in hospital or home, we care, let\'s first learn about a patient.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontFamily: 'poppins',
                ),
              ),
              SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name
Container(
  color: Colors.white, 
  child: TextFormField(
    controller: _nameController,
    style: TextStyle(
      fontFamily: 'Poppins', 
    ),
    decoration: InputDecoration(
      labelText: 'Full Name',
      labelStyle: TextStyle(
        fontFamily: 'Poppins', // 
        color: Colors.grey[700], // Optional: style label color
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey), 

      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter patient\'s name';
      }
      return null;
    },
  ),
),
                    SizedBox(height: 16),
                    
                    // Date of Birth
                    Row(
                      children: [
                        // Month
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _selectedDate?.month,
                                hint: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Month'),
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      final now = DateTime.now();
                                      final day = _selectedDate?.day ?? 1;
                                      final year = _selectedDate?.year ?? now.year;
                                      _selectedDate = DateTime(year, value, day);
                                    });
                                  }
                                },
                                items: List.generate(12, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('${index + 1}'),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Day
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Day',
                              filled: true, 
                              fillColor: Colors.white, 

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                final day = int.tryParse(value) ?? 1;
                                setState(() {
                                  final now = DateTime.now();
                                  final month = _selectedDate?.month ?? now.month;
                                  final year = _selectedDate?.year ?? now.year;
                                  _selectedDate = DateTime(year, month, day);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Year
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Year',
                              filled: true, 
                              fillColor: Colors.white, 

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                final year = int.tryParse(value) ?? DateTime.now().year;
                                setState(() {
                                  final now = DateTime.now();
                                  final month = _selectedDate?.month ?? now.month;
                                  final day = _selectedDate?.day ?? 1;
                                  _selectedDate = DateTime(year, month, day);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Phone Number
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        filled: true, 
                        fillColor: Colors.white, 

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/flags/uganda.png',
                                width: 24,
                                height: 16,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.flag, size: 24);
                                },
                              ),
                              SizedBox(width: 4),
                              Text(_countryCode),
                              Icon(Icons.arrow_drop_down),
                              SizedBox(width: 8),
                              Container(
                                height: 24,
                                width: 1,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Gender Selection
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedGender = 'Male';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _selectedGender == 'Male' ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      color: _selectedGender == 'Male' ? Colors.black : Colors.grey[600],
                                      fontWeight: _selectedGender == 'Male' ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedGender = 'Female';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _selectedGender == 'Female' ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      color: _selectedGender == 'Female' ? Colors.black : Colors.grey[600],
                                      fontWeight: _selectedGender == 'Female' ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
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
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      model.setPersonalInfo(
                        name: _nameController.text,
                        dob: _selectedDate,
                        phone: _phoneController.text,
                        code: _countryCode,
                        selectedGender: _selectedGender,
                      );
                      model.nextStep();
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => MedicalInfoScreen()),
                     );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Continue'),
                  ),
style: ElevatedButton.styleFrom(
  backgroundColor: Colors.blue,         // Background color (button itself)
  foregroundColor: Colors.white,       // Text/icon color
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