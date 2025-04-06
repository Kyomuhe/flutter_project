import 'package:flutter/material.dart';

void main() {
  runApp(const PushNotificationApp());
}

class PushNotificationApp extends StatelessWidget {
  const PushNotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Notifications Guide',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const PushNotificationGuide(),
    );
  }
}

class PushNotificationGuide extends StatelessWidget {
  const PushNotificationGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications',
        style: TextStyle(color: Colors.white,
        ),),
        backgroundColor: Colors.blue,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildFlowDiagram(context),
            const SizedBox(height: 20),
            _buildBasicConcepts(context),
            const SizedBox(height: 20),
            _buildPlatformInfo(context),
            const SizedBox(height: 20),
            _buildBestPractices(context),
            const SizedBox(height: 20),
            _buildFlutterImplementation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Understanding Push Notifications',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Push notifications are messages sent from a server to a user\'s device, appearing as alerts, badges, or banners even when the app is not actively being used. They help re-engage users with timely information.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowDiagram(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How Push Notifications Work',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: _buildFlowStep(
                      context,
                      '1',
                      'Registration',
                      'App registers with platform\'s Push Notification Service (PNS) and receives a device token',
                      Icons.app_registration,
                      colorScheme.primary,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: colorScheme.primary),
                  Expanded(
                    child: _buildFlowStep(
                      context,
                      '2',
                      'Server',
                      'App server sends notification content with device token to the appropriate PNS',
                      Icons.cloud,
                      colorScheme.secondary,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: colorScheme.primary),
                  Expanded(
                    child: _buildFlowStep(
                      context,
                      '3',
                      'PNS',
                      'Firebase (Android) or APNS (iOS) validates and routes the notification',
                      Icons.router,
                      colorScheme.tertiary,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: colorScheme.primary),
                  Expanded(
                    child: _buildFlowStep(
                      context,
                      '4',
                      'Device',
                      'OS receives and displays the notification based on user settings',
                      Icons.phone_android,
                      colorScheme.error,
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

  Widget _buildFlowStep(BuildContext context, String number, String title,
      String description, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Text(
            number,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBasicConcepts(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Components',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildConceptItem(
              context,
              'App Provider/Backend Server',
              'The source that initiates and sends notification content',
              Icons.dns,
            ),
            _buildConceptItem(
              context,
              'Push Notification Service (PNS)',
              'Platform-specific services like Firebase Cloud Messaging (Android) or Apple Push Notification Service (iOS)',
              Icons.hub,
            ),
            _buildConceptItem(
              context,
              'Client App',
              'The application installed on the user\'s device that receives and displays notifications',
              Icons.smartphone,
            ),
            _buildConceptItem(
              context,
              'Device Token',
              'A unique identifier generated during registration that targets specific devices',
              Icons.key,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptItem(
      BuildContext context, String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform-Specific Implementation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildPlatformCard(
                    context,
                    'Android',
                    [
                      'Uses Firebase Cloud Messaging (FCM)',
                      'Requires Firebase project setup',
                      'Payload size: 4KB (notification) + 4KB (data)',
                      'More flexible display options',
                    ],
                    Icons.android,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPlatformCard(
                    context,
                    'iOS',
                    [
                      'Uses Apple Push Notification Service (APNS)',
                      'Requires Apple Developer account',
                      'Strict payload size limits (4KB total)',
                      'Explicit user permission needed',
                    ],
                    Icons.apple,
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCard(BuildContext context, String platform,
      List<String> features, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(height: 8),
          Text(
            platform,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: Theme.of(context).textTheme.bodyMedium),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBestPractices(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best Practices',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildPracticeChip(context, 'Request clear permission'),
                _buildPracticeChip(context, 'Send relevant content only'),
                _buildPracticeChip(context, 'Personalize messages'),
                _buildPracticeChip(context, 'Be mindful of timing'),
                _buildPracticeChip(context, 'Avoid notification fatigue'),
                _buildPracticeChip(context, 'Provide clear opt-out options'),
                _buildPracticeChip(context, 'Track engagement metrics'),
                _buildPracticeChip(context, 'Implement deep linking'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeChip(BuildContext context, String label) {
    return Chip(
      label: Text(label),
      avatar: Icon(
        Icons.check_circle,
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    );
  }

  Widget _buildFlutterImplementation(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Implementation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Common Flutter Packages:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildPackageItem(
                    context,
                    'firebase_messaging',
                    'Official Firebase Cloud Messaging plugin for Flutter',
                  ),
                  _buildPackageItem(
                    context,
                    'flutter_local_notifications',
                    'For displaying local notifications and handling received push data',
                  ),
                  _buildPackageItem(
                    context,
                    'awesome_notifications',
                    'Advanced notification features with custom UI',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Basic Implementation Steps:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildStepItem(context, '1. Add dependencies to pubspec.yaml'),
                  _buildStepItem(context,
                      '2. Configure platform-specific settings (Android/iOS)'),
                  _buildStepItem(
                      context, '3. Initialize Firebase in your Flutter app'),
                  _buildStepItem(
                      context, '4. Request notification permissions from user'),
                  _buildStepItem(context, '5. Get and store the FCM token'),
                  _buildStepItem(context,
                      '6. Set up handlers for different notification states'),
                  _buildStepItem(
                      context, '7. Configure notification display options'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageItem(
      BuildContext context, String packageName, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.code, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  packageName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right,
              size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              step,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}