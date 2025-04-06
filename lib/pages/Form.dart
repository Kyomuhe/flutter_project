import 'package:flutter/material.dart';

void main() {
  runApp(const FormPage());
}

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Forms Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormExample(),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({Key? key}) : super(key: key);

  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  // Form key to validate form
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Dropdown value
  String _selectedGender = 'Male';
  
  // Checkbox state
  bool _agreeToTerms = false;
  
  // Radio button value
  int _notificationOption = 1;
  
  // Slider value
  double _age = 25;
  
  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Forms'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic TextField
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your full name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Email TextField with validation
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Password TextField
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Dropdown Button
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Slider
                Text('Age: ${_age.round()}'),
                Slider(
                  value: _age,
                  min: 18,
                  max: 80,
                  divisions: 62,
                  label: _age.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Radio Buttons
                const Text('Notification Preferences:'),
                RadioListTile<int>(
                  title: const Text('Email notifications'),
                  value: 1,
                  groupValue: _notificationOption,
                  onChanged: (value) {
                    setState(() {
                      _notificationOption = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text('SMS notifications'),
                  value: 2,
                  groupValue: _notificationOption,
                  onChanged: (value) {
                    setState(() {
                      _notificationOption = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text('No notifications'),
                  value: 3,
                  groupValue: _notificationOption,
                  onChanged: (value) {
                    setState(() {
                      _notificationOption = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Checkbox
                CheckboxListTile(
                  title: const Text('I agree to the terms and conditions'),
                  value: _agreeToTerms,
                  onChanged: (newValue) {
                    setState(() {
                      _agreeToTerms = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 24),
                
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agreeToTerms) {
                        // Process data here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else if (!_agreeToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please agree to terms')),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text('Submit', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}