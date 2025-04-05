import 'package:flutter/material.dart';

class FlutterWidgetsPage extends StatelessWidget {
  const FlutterWidgetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widgets'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding Flutter Widgets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'In Flutter, everything is a widget. Widgets are the building blocks of your app\'s user interface.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // Basic Widgets Section
            _buildSectionTitle('Basic Widgets'),
            const SizedBox(height: 8),
            _buildWidgetExample(
              'Text',
              'Displays styled text',
              'Text("Hello World", style: TextStyle(fontSize: 20))',
              const Text("Hello World", style: TextStyle(fontSize: 20)),
            ),
            _buildWidgetExample(
              'Container',
              'A rectangular visual element',
              'Container(color: Colors.blue, height: 50, width: 50)',
              Container(color: Colors.blue, height: 50, width: 50),
            ),
            _buildWidgetExample(
              'Icon',
              'Graphical icon from material design',
              'Icon(Icons.star, color: Colors.amber, size: 40)',
              const Icon(Icons.star, color: Colors.amber, size: 40),
            ),
            
            // Input Widgets Section
            _buildSectionTitle('Input Widgets'),
            const SizedBox(height: 8),
            _buildWidgetExample(
              'ElevatedButton',
              'Material design button',
              'ElevatedButton(onPressed: () {}, child: Text("Click me"))',
              ElevatedButton(onPressed: () {}, child: const Text("Click me")),
            ),
            _buildWidgetExample(
              'TextField',
              'Input text field',
              'TextField(decoration: InputDecoration(labelText: "Enter text"))',
              const TextField(decoration: InputDecoration(labelText: "Enter text")),
            ),
            
            // Display Widgets Section
            _buildSectionTitle('Display Widgets'),
            const SizedBox(height: 8),
            _buildWidgetExample(
              'Image',
              'Display images',
              'Image.asset("assets/image.png")',
              Container(
                color: Colors.grey[300],
                height: 100,
                width: 100,
                child: const Center(child: Text('Image')),
              ),
            ),
            _buildWidgetExample(
              'CircleAvatar',
              'Circular profile picture',
              'CircleAvatar(radius: 30, backgroundColor: Colors.green)',
              const CircleAvatar(radius: 30, backgroundColor: Colors.green),
            ),
            
            // Layout Widgets Section
            _buildSectionTitle('Layout Widgets'),
            const SizedBox(height: 8),
            _buildWidgetExample(
              'Row',
              'Horizontal layout',
              'Row(children: [Widget1, Widget2, Widget3])',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(color: Colors.red, height: 30, width: 30),
                  Container(color: Colors.green, height: 30, width: 30),
                  Container(color: Colors.blue, height: 30, width: 30),
                ],
              ),
            ),
            _buildWidgetExample(
              'Column',
              'Vertical layout',
              'Column(children: [Widget1, Widget2, Widget3])',
              Column(
                children: [
                  Container(color: Colors.purple, height: 20, width: 60),
                  const SizedBox(height: 5),
                  Container(color: Colors.orange, height: 20, width: 60),
                  const SizedBox(height: 5),
                  Container(color: Colors.teal, height: 20, width: 60),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text(
              'Widget Hierarchy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Root Widget (MaterialApp/CupertinoApp)'),
                  Text('2. Structure Widgets (Scaffold, Navigator)'),
                  Text('3. Layout Widgets (Container, Row, Column)'),
                  Text('4. UI Elements (Text, Button, Image)'),
                  Text('5. Styling and Positioning (Padding, Align)'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text(
              'Widget Lifecycle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• createState()'),
                  Text('• initState()'),
                  Text('• didChangeDependencies()'),
                  Text('• build()'),
                  Text('• didUpdateWidget()'),
                  Text('• setState()'),
                  Text('• dispose()'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }
  
  Widget _buildWidgetExample(String name, String description, String code, Widget example) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(code, style: const TextStyle(fontFamily: 'monospace')),
            ),
            const SizedBox(height: 16),
            Center(child: example),
          ],
        ),
      ),
    );
  }
}