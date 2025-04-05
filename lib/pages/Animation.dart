import 'package:flutter/material.dart';

class FlutterAnimationsPage extends StatefulWidget {
  const FlutterAnimationsPage({Key? key}) : super(key: key);

  @override
  State<FlutterAnimationsPage> createState() => _FlutterAnimationsPageState();
}

class _FlutterAnimationsPageState extends State<FlutterAnimationsPage>
    with SingleTickerProviderStateMixin {
  // Animation controller for demonstration purposes
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller with 2-second duration
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Create a curved animation for smooth effect
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Color animation from purple to orange
    _colorAnimation = ColorTween(
      begin: Colors.purple,
      end: Colors.orange,
    ).animate(_controller);

    // Size animation from 50 to 200
    _sizeAnimation = Tween<double>(
      begin: 50,
      end: 150,
    ).animate(_controller);

    // Make the animation repeat
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding Flutter Animations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Animations make your app more dynamic and engaging. Flutter provides powerful animation capabilities that are easy to implement.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // Basic Animation Concepts
            _buildSectionTitle('Animation Concepts'),
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
                  Text('• AnimationController: Controls the animation', 
                       style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('• Animation: Defines how values change over time'),
                  Text('• Tween: Interpolates between beginning and ending values'),
                  Text('• Curve: Defines the rate of change (e.g., linear, ease, bounce)'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Implicit Animations
            _buildSectionTitle('Implicit Animations'),
            const SizedBox(height: 8),
            const Text(
              'Implicit animations are the simplest way to animate in Flutter. Just change a property and specify a duration.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // AnimatedContainer Example
            _buildAnimationExample(
              'AnimatedContainer',
              'Changes properties with animation',
              const AnimatedContainerExample(),
            ),
            
            // Animated Opacity Example
            _buildAnimationExample(
              'AnimatedOpacity',
              'Fades a widget in or out',
              const AnimatedOpacityExample(),
            ),
            
            // Explicit Animations
            _buildSectionTitle('Explicit Animations'),
            const SizedBox(height: 8),
            const Text(
              'Explicit animations give you more control using AnimationController and Animation classes.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Animated Builder Example
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AnimatedBuilder', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Custom animation with fine-grained control'),
                    const SizedBox(height: 16),
                    Center(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            width: _sizeAnimation.value,
                            height: _sizeAnimation.value,
                            decoration: BoxDecoration(
                              color: _colorAnimation.value,
                              borderRadius: BorderRadius.circular(_animation.value * 50),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Key points:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• Uses AnimationController with SingleTickerProviderStateMixin'),
                    const Text('• Multiple animations can be controlled by one controller'),
                    const Text('• Animation values update with each frame'),
                  ],
                ),
              ),
            ),
            
            // Hero Animation
            _buildSectionTitle('Hero Animations'),
            const SizedBox(height: 8),
            const Text(
              'Hero animations create a visual connection between screens when navigating.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hero', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Animated transition between screens'),
                    const SizedBox(height: 16),
                    Center(
                      child: Hero(
                        tag: 'hero-example',
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                          child: const Center(
                            child: Text('Hero', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Use the same tag on both screens to connect them'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HeroDestinationPage(),
                          ),
                        );
                      },
                      child: const Text('See Hero Animation'),
                    ),
                  ],
                ),
              ),
            ),
            
            // Animation Packages
            _buildSectionTitle('Animation Packages'),
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
                  Text('For more complex animations, consider these packages:', 
                       style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• flutter_animate: Simple API for complex animations'),
                  Text('• rive: Run interactive animations created with Rive'),
                  Text('• lottie: Support for Lottie animations'),
                  Text('• animated_text_kit: Pre-built text animations'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text(
              'Animation Best Practices:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Text('• Keep animations subtle and purposeful'),
                  Text('• Use animations to guide user attention'),
                  Text('• Ensure animations complete quickly (< 500ms)'),
                  Text('• Test animations on low-end devices'),
                  Text('• Always dispose of animation controllers'),
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
  
  Widget _buildAnimationExample(String name, String description, Widget example) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Center(child: example),
          ],
        ),
      ),
    );
  }
}

// Example of AnimatedContainer
class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: _isExpanded ? 200 : 100,
          height: _isExpanded ? 100 : 100,
          color: _isExpanded ? Colors.green : Colors.red,
          child: Center(
            child: Text(
              _isExpanded ? 'Expanded' : 'Normal',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(_isExpanded ? 'Shrink' : 'Expand'),
        ),
      ],
    );
  }
}

// Example of AnimatedOpacity
class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({Key? key}) : super(key: key);

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Fade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: Text(_isVisible ? 'Hide' : 'Show'),
        ),
      ],
    );
  }
}

// Hero Destination Page
class HeroDestinationPage extends StatelessWidget {
  const HeroDestinationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation Detail'),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-example',
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Hero Animation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}