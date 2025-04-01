import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assets",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 8,
      ),
      body: SingleChildScrollView(
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
                    '1. I defined assets in pubspec.yaml:',
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
      ),
    );
  }
}