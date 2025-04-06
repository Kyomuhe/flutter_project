import 'package:flutter/material.dart';

void main() {
  runApp(const FirebaseGuideApp());
}

class FirebaseGuideApp extends StatelessWidget {
  const FirebaseGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const FirebaseGuidePage(),
    );
  }
}

class FirebaseGuidePage extends StatelessWidget {
  const FirebaseGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Guide'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: const FirebaseContent(),
    );
  }
}

class FirebaseContent extends StatelessWidget {
  const FirebaseContent({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          
          // Core Firebase Services
          _buildServiceCards(context),
          
          const SizedBox(height: 24),
          
          // Setup Requirements
          _buildSetupRequirements(context),
          
          const SizedBox(height: 24),
          
          // Security & Best Practices
          _buildSecurityAndBestPractices(context),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Card(
      elevation: 4,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.blue, size: 36),
                const SizedBox(width: 12),
                const Text(
                  'Firebase in Flutter',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'A Backend-as-a-Service (BaaS) platform by Google that provides ready-to-use backend services for mobile and web applications.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceCards(BuildContext context) {
    final services = [
      ServiceInfo(
        title: 'Authentication',
        description: 'User authentication with multiple sign-in methods',
        icon: Icons.security,
        features: ['Email/Password', 'Social logins', 'Phone verification', 'Custom auth'],
      ),
      ServiceInfo(
        title: 'Cloud Firestore',
        description: 'NoSQL document database with real-time updates',
        icon: Icons.cloud,
        features: ['Document-based', 'Real-time data', 'Offline support', 'Queries & filters'],
      ),
      ServiceInfo(
        title: 'Storage',
        description: 'File storage for images, videos, and other files',
        icon: Icons.storage,
        features: ['Secure uploads', 'Download options', 'Progress tracking', 'Access control'],
      ),
      ServiceInfo(
        title: 'Cloud Messaging',
        description: 'Push notifications and messaging',
        icon: Icons.message,
        features: ['Device targeting', 'Topic subscriptions', 'Data messages', 'Background handling'],
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Core Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(services[index]);
          },
        ),
      ],
    );
  }
  
  Widget _buildServiceCard(ServiceInfo service) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(service.icon, color: Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      service.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                service.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: service.features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, size: 14, color: Colors.blue),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSetupRequirements(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Setup Requirements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              '1',
              'Create Firebase Project',
              'Go to Firebase Console and create a new project',
            ),
            _buildStepItem(
              '2',
              'Add App to Project',
              'Register your Android/iOS app and download config files',
            ),
            _buildStepItem(
              '3',
              'Add Dependencies',
              'Add Firebase packages to your pubspec.yaml',
            ),
            _buildStepItem(
              '4',
              'Initialize Firebase',
              'Call Firebase.initializeApp() in your main.dart',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Dependencies:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'firebase_core: ^2.24.2\n'
                    'firebase_auth: ^4.15.3\n'
                    'cloud_firestore: ^4.13.6\n'
                    'firebase_storage: ^11.5.6\n'
                    'firebase_messaging: ^14.7.9',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStepItem(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSecurityAndBestPractices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security & Best Practices',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPracticeCard(
                'Security',
                [
                  'Implement proper security rules',
                  'Don\'t expose API keys publicly',
                  'Use environment variables',
                  'Implement proper error handling',
                  'Follow Firebase security guides',
                ],
                Icons.shield,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPracticeCard(
                'Best Practices',
                [
                  'Initialize Firebase early',
                  'Use offline persistence when needed',
                  'Implement proper state management',
                  'Stay updated with Firebase docs',
                  'Test thoroughly before deployment',
                ],
                Icons.thumb_up,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPracticeCard(String title, List<String> items, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class ServiceInfo {
  final String title;
  final String description;
  final IconData icon;
  final List<String> features;
  
  ServiceInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
  });
}