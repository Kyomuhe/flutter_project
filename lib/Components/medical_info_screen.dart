// screens/medical_info_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_registration_model.dart';
import '../widgets/progress_indicator.dart';
import 'location_screen.dart';

class MedicalInfoScreen extends StatefulWidget {
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  String _selectedCondition = '';
  
  @override
  void dispose() {
    _diagnosisController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PatientRegistrationModel>(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
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
                    SizedBox(width: 8), // Added space between icon and text
                    Text(
                      'Patients information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'That was so easy, let\'s finish up here.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient's current condition
                      Center(
                        child: Container(
                          width: double.infinity, // Changed from fixed width to dynamic
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000), // 10% opacity black
                                offset: Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.local_hospital, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Patient\'s current condition',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins', // Optional if you're using Poppins
                                ),
                              ),
                              Text(
                                ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down, color: Colors.blue),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Condition options
                      Row(
                        children: [
                          Expanded(
                            child: _buildConditionButton('ICU'),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildConditionButton('ARDS'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildConditionButton('Stroke'),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildConditionButton('Others'),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      
                      // Diagnosis
                      Row(
                        children: [
                          Text(
                            'Diagnosis',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _diagnosisController,
                        decoration: InputDecoration(
                          hintText: 'Type a clear description here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter diagnosis details';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      
                      // Attach medical report
                      Text(
                        'Attach current medical reports (if any)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // Implementation to attach medical report
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Tap here to attach medical report',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50), // Added extra space before the button
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_selectedCondition.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a condition')),
                          );
                          return;
                        }
                        
                        model.setMedicalInfo(
                          condition: _selectedCondition,
                          diagnosisInfo: _diagnosisController.text,
                        );
                        model.nextStep();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LocationScreen()),
                       );
                      }
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
      ),
    );
  }
  
  Widget _buildConditionButton(String condition) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCondition = condition;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue, // Always blue border, regardless of selection state
            width: _selectedCondition == condition ? 2.0 : 1.0, // Make selected border thicker
          ),
          borderRadius: BorderRadius.circular(8),
          color: _selectedCondition == condition ? Colors.blue.withOpacity(0.1) : Colors.white,
        ),
        child: Center(
          child: Text(
            condition,
            style: TextStyle(
              color: _selectedCondition == condition ? Colors.blue : Colors.black,
              fontWeight: _selectedCondition == condition ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}