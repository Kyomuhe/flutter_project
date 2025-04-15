// models/patient_registration_model.dart
import 'package:flutter/material.dart';

class PatientRegistrationModel extends ChangeNotifier {
  // Patient personal info
  String fullName = '';
  DateTime? dateOfBirth;
  String phoneNumber = '';
  String countryCode = '+256';
  String gender = 'Male';
  
  // Patient medical info
  String currentCondition = '';
  String diagnosis = '';
  String? medicalReportPath;
  
  // Patient location
  String location = '';
  String fullAddress = '';
  
  // Selected days for nursing
  List<DateTime> selectedDays = [];
  
  // Current step in the registration process (0-3)
  int currentStep = 0;
  
  void setPersonalInfo({
    required String name,
    required DateTime? dob,
    required String phone,
    required String code,
    required String selectedGender,
  }) {
    fullName = name;
    dateOfBirth = dob;
    phoneNumber = phone;
    countryCode = code;
    gender = selectedGender;
    notifyListeners();
  }
  
  void setMedicalInfo({
    required String condition,
    required String diagnosisInfo,
    String? reportPath,
  }) {
    currentCondition = condition;
    diagnosis = diagnosisInfo;
    medicalReportPath = reportPath;
    notifyListeners();
  }
  
  void setLocationInfo({
    required String locationName,
    required String address,
  }) {
    location = locationName;
    fullAddress = address;
    notifyListeners();
  }
  
  void setSelectedDays(List<DateTime> days) {
    selectedDays = days;
    notifyListeners();
  }
  
  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      notifyListeners();
    }
  }
  
  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }
}