import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Learning",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 8,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(
              icon: Icon(Icons.image),
              text: "Assets",
            ),
            Tab(
              icon: Icon(Icons.data_usage),
              text: "State Management",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AssetsTab(),
          StateManagementTab(),
        ],
      ),
    );
  }
}

class AssetsTab extends StatelessWidget {
  const AssetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Local asset image
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Local Asset Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Local image from assets folder
                Image(
                  image: const AssetImage('assets/pic.jpg'),
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This image is loaded from the assets directory defined in pubspec.yaml',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const Divider(thickness: 2),
          
          // Network image with explanation
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Network Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Network image from URL
                Image(
                  image: const NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  ),
                  width: 300,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load image');
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  'This image is loaded from a network URL with loading and error handling',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const Divider(thickness: 2),
          
          // Asset information section
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Working with Assets in Flutter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '1. Define assets in pubspec.yaml:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('''
assets:
  - assets/pic.jpg
  - assets/images/
'''),
                SizedBox(height: 8),
                Text(
                  '2. Access assets in code:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Images: AssetImage(\'assets/pic.jpg\')'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StateManagementTab extends StatelessWidget {
  const StateManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flutter State Management Patterns',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          
          // Provider
          _buildStateManagementCard(
            'Provider',
            'A simple approach that implements InheritedWidget in a more developer-friendly way.',
            [
              'Lightweight dependency injection',
              'Good for app-wide state',
              'Works well with ChangeNotifier',
              'Official Flutter recommendation',
            ],
            Colors.blue.shade50,
            Colors.blue,
          ),

          // Bloc
          _buildStateManagementCard(
            'Bloc (Business Logic Component)',
            'Separates business logic from UI using streams with unidirectional data flow.',
            [
              'Clear separation of concerns',
              'Event-driven architecture',
              'Great for complex applications',
              'Highly testable',
            ],
            Colors.purple.shade50,
            Colors.purple,
          ),

          // Riverpod
          _buildStateManagementCard(
            'Riverpod',
            'An evolution of Provider that addresses some of its limitations.',
            [
              'Type-safe dependency injection',
              'Compiler-time safety',
              'Better handling of async data',
              'Improved provider composition',
            ],
            Colors.green.shade50,
            Colors.green,
          ),

          // GetX
          _buildStateManagementCard(
            'GetX',
            'A lightweight solution that also offers navigation and dependency injection.',
            [
              'Minimal boilerplate code',
              'Performance-focused',
              'Simple reactive programming',
              'Built-in navigation management',
            ],
            Colors.orange.shade50,
            Colors.orange,
          ),

          // Redux
          _buildStateManagementCard(
            'Redux',
            'Uses a centralized store with reducers to manage state.',
            [
              'Single source of truth (store)',
              'Immutable state',
              'Pure function reducers',
              'Middleware support',
              'Time-travel debugging',
            ],
            Colors.red.shade50,
            Colors.red,
          ),

          // MobX
          _buildStateManagementCard(
            'MobX',
            'Uses observables and reactions to create a reactive programming model.',
            [
              'Simplified reactive programming',
              'Less boilerplate than alternatives',
              'Automatic tracking of dependencies',
              'Computed values',
            ],
            Colors.teal.shade50,
            Colors.teal,
          ),

          const SizedBox(height: 16),
          const Text(
            'Choosing the Right Approach',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildRecommendationItem('Simple apps', 'Provider or GetX'),
          _buildRecommendationItem('Complex, large-scale apps', 'Bloc or Riverpod'),
          _buildRecommendationItem('React background', 'Redux or MobX'),
          _buildRecommendationItem('Performance critical', 'GetX or optimized Provider'),
        ],
      ),
    );
  }

  Widget _buildStateManagementCard(
    String title,
    String description,
    List<String> features,
    Color backgroundColor,
    Color accentColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Key Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: accentColor),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String scenario, String recommendation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '$scenario: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: recommendation),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}