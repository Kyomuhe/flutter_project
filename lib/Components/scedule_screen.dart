// screens/schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_registration_model.dart';
import '../widgets/progress_indicator.dart';
//import 'billing_screen.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _currentMonth = DateTime(2025, 8);
  List<DateTime> _selectedDays = [];
  
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PatientRegistrationModel>(context);
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Setting the background color to #F5F5F5
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () {
                      model.previousStep();
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Number of Days',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              
              // Description text
              Text(
                'Lastly, select the number of days when you will need nursing at home/office.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              
              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Calendar
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5), // #F5F5F5 background
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0, // 3px solid white border
                            ),
                          ),
                          child: Column(
                            children: [
                              // Month navigation
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Previous month button
                                    Container(
                                      width: 36.91, // Specified width
                                      height: 36.91, // Specified height
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.chevron_left, size: 20),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            _currentMonth = DateTime(
                                              _currentMonth.year,
                                              _currentMonth.month - 1,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    
                                    // Month and year in separate containers
                                    Row(
                                      children: [
                                        // Month container
                                        Container(
                                          width: 76.08, // Specified width
                                          height: 36.91, // Specified height
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              _getMonthName(_currentMonth.month),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Year container
                                        Container(
                                          width: 76.08, // Specified width
                                          height: 36.91, // Specified height
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              _currentMonth.year.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Next month button
                                    Container(
                                      width: 36.91, // Specified width
                                      height: 36.91, // Specified height
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.chevron_right, size: 20),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            _currentMonth = DateTime(
                                              _currentMonth.year,
                                              _currentMonth.month + 1,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Weekday headers
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _weekdayHeader('Mo'),
                                    _weekdayHeader('Tu'),
                                    _weekdayHeader('We'),
                                    _weekdayHeader('Th'),
                                    _weekdayHeader('Fr'),
                                    _weekdayHeader('Sa'),
                                    _weekdayHeader('Su'),
                                  ],
                                ),
                              ),
                              
                              // Calendar grid
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildCalendarGrid(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        // Tip
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              'Tip: tap days to select',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        
                        // Add extra padding at the bottom to ensure scrollability
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Fixed bottom area for button and progress indicator
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedDays.isNotEmpty) {
                      model.setSelectedDays(_selectedDays);
                      //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => BillingScreen()),
                      //);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select at least one day')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Continue to Billing'),
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
              SizedBox(height: 12),
              StepProgressIndicator(currentStep: model.currentStep, totalSteps: 4),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _weekdayHeader(String day) {
    return Expanded(
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCalendarGrid() {
    // Get the number of days in the month
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    
    // Get the weekday of the first day (0 = Monday, 6 = Sunday)
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = (firstDayOfMonth.weekday - 1) % 7;
    
    // Calculate number of days from previous month to show
    final lastDayOfPrevMonth = DateTime(_currentMonth.year, _currentMonth.month, 0).day;
    final daysFromPrevMonth = firstWeekday;
    
    // Calculate rows needed for the calendar
    final totalDays = daysFromPrevMonth + daysInMonth;
    final rowCount = (totalDays / 7).ceil();
    
    List<Widget> rows = [];
    
    int day = 1;
    int nextMonthDay = 1;
    
    for (int i = 0; i < rowCount; i++) {
      List<Widget> cells = [];
      
      for (int j = 0; j < 7; j++) {
        if (i == 0 && j < firstWeekday) {
          // Previous month
          int prevDay = lastDayOfPrevMonth - (firstWeekday - j - 1);
          cells.add(_calendarCell(prevDay, isCurrentMonth: false));
        } else if (day <= daysInMonth) {
          // Current month
          final currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
          final isSelected = _selectedDays.any((d) => 
              d.year == currentDate.year && 
              d.month == currentDate.month && 
              d.day == currentDate.day
          );
          
          cells.add(_calendarCell(
            day, 
            isCurrentMonth: true,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedDays.removeWhere((d) => 
                      d.year == currentDate.year && 
                      d.month == currentDate.month && 
                      d.day == currentDate.day
                  );
                } else {
                  _selectedDays.add(currentDate);
                }
              });
            },
          ));
          day++;
        } else {
          // Next month
          cells.add(_calendarCell(nextMonthDay, isCurrentMonth: false));
          nextMonthDay++;
        }
      }
      
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: cells,
        ),
      );
    }
    
    return Column(
      children: rows.map((row) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: row,
      )).toList(),
    );
  }
  
  Widget _calendarCell(int day, {
    required bool isCurrentMonth,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: isCurrentMonth ? onTap : null,
          child: Container(
            width: 40.68, // Specified width
            height: 38.42, // Specified height
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.blue 
                  : (isCurrentMonth ? Colors.white : Colors.transparent),
              borderRadius: BorderRadius.circular(9),
              boxShadow: isCurrentMonth && !isSelected ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ] : null,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected 
                      ? Colors.white 
                      : (isCurrentMonth ? Colors.black : Colors.grey[400]),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}