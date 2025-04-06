import 'package:flutter/material.dart';
import 'pages/FirstPage.dart';
import 'pages/riverPod.dart';
import 'pages/SideMenu.dart'; 
import 'pages/Widget.dart'; 
import 'pages/Animation.dart';
import 'pages/Form.dart';
import 'pages/LocalStorage.dart';
import 'pages/FireBase.dart';
import 'pages/Theming.dart';
import 'pages/Notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precious Research',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/first': (context) => const MainPage(),
        '/river': (context) => const App(),
        '/widgets': (context) => const FlutterWidgetsPage(),
        '/animations': (context) => const FlutterAnimationsPage(),
        '/form': (context) => const FormPage(),
        '/local': (context) => const LocalStorage(),
        '/firebase': (context) => const FirebaseGuideApp(),
        'theming' : (context) => const ThemingPage(),
        'notification' : (context) => const PushNotificationApp(),
        





      },
      home: const MyHomePage(title: 'My Research'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(), // Add the drawer using your SideMenu widget
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Remove the title and replace with leading burger icon
        // The burger icon is automatically added by Scaffold when you use drawer
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Push button to the right
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/first');
              },
              child: const Text(
                'More Concepts',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.flutter_dash), text: "Flutter basics"),
            Tab(icon: Icon(Icons.home), text: "Stateless"),
            Tab(icon: Icon(Icons.sync), text: "Stateful"),
            Tab(icon: Icon(Icons.list), text: "Layout"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FlutterBasics(),
          StatelessWidgetExample(),
          StatefulWidgetExample(),
          LayoutWidgetsExample(),
        ],
      ),
    );
  }
}

//introduction to flutter
class FlutterBasics extends StatelessWidget {
  const FlutterBasics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Introduction to Flutter',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Flutter is Google\'s mobile SDK that builds native Andriod and ios apps from a single codebase using Dart programming language.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Key Advantages of Flutter', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('1. Cross-platform development: Write once, run anywhere (iOS, Android, Web, Desktop)'),
                  const SizedBox(height: 8),
                  const Text('2. Hot reload: Instantly see changes without restarting your app'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text('Used by Google, Alibaba, BMW, eBay and more'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'For the set up I downloaded the flutter extension of Vs code and downloaded the SDK because Andriod studio makes my PC slow'
            ,
            style: TextStyle(
              fontSize: 16
              ),
          ),
          const SizedBox(height: 24),
          const Text(
            'TABS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Flutter uses TabBarView widget to display multiple screens, These are parts of the UI that navigate the user through different routes'
            ,
            style: TextStyle(
              fontSize: 16
            ),
  
            ),
            const SizedBox(height: 24),
            const Text(
            '* I have used TabBarView to display my different screens',
            style: TextStyle(fontSize: 16),
          ),


        ],
      ),
    );
  }
}

// Demonstration of Stateless Widgets
class StatelessWidgetExample extends StatelessWidget {
  const StatelessWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stateless Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Stateless widgets are immutable and their properties cannot be changed.These are used for static content or UI that dont change for example Displaying text,icons etc',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Simple Card Widget', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('This is a card with static content that doesn\'t change.'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text('Informational content'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const CustomStatelessWidget(
            title: 'Custom Stateless Widget',
            description: 'This is a reusable component with properties.',
            iconData: Icons.star,
          ),
        ],
      ),
    );
  }
}

// Custom Stateless Widget Example
class CustomStatelessWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  
  const CustomStatelessWidget({
    super.key, 
    required this.title, 
    required this.description, 
    required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, color: Colors.orange),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold
              )),
            ],
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

// Demonstration of Stateful Widgets
class StatefulWidgetExample extends StatefulWidget {
  const StatefulWidgetExample({super.key});

  @override
  State<StatefulWidgetExample> createState() => _StatefulWidgetExampleState();
}

class _StatefulWidgetExampleState extends State<StatefulWidgetExample> {
  int _counter = 0;
  bool _isToggled = false;
  double _sliderValue = 0.5;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stateful Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Stateful widgets can change their state over time in response to user actions or events forexample buttons,sliders, text fields.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Counter Example', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(
                    'Count: $_counter',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Interactive Controls', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Toggle:'),
                      const SizedBox(width: 8),
                      Switch(
                        value: _isToggled,
                        onChanged: (value) {
                          setState(() {
                            _isToggled = value;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      Text(_isToggled ? 'ON' : 'OFF'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Slider:'),
                      Expanded(
                        child: Slider(
                          value: _sliderValue,
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                            });
                          },
                        ),
                      ),
                      Text('${(_sliderValue * 100).round()}%'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Layout Widgets Examples
class LayoutWidgetsExample extends StatelessWidget {
  const LayoutWidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Layout Widgets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Layout widgets help arrange other widgets on the screen.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text('Row Example:', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColoredBox(Colors.red),
                  _buildColoredBox(Colors.green),
                  _buildColoredBox(Colors.blue),
                ],
              ),
            ),
            const Text('Column Example:', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColoredBox(Colors.purple),
                  _buildColoredBox(Colors.orange),
                  _buildColoredBox(Colors.teal),
                ],
              ),
            ),
            const Text('Stack Example:', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              height: 100,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.amber,
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.red.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    bottom: 10,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text('GridView Example:', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 200,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildGridItem(Colors.red, 'Item 1'),
                  _buildGridItem(Colors.green, 'Item 2'),
                  _buildGridItem(Colors.blue, 'Item 3'),
                  _buildGridItem(Colors.yellow, 'Item 4'),
                  _buildGridItem(Colors.purple, 'Item 5'),
                  _buildGridItem(Colors.teal, 'Item 6'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColoredBox(Color color) {
    return Container(
      width: 50,
      height: 50,
      color: color,
    );
  }
  
  Widget _buildGridItem(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}