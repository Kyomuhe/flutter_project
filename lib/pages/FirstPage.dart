import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assets",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      
      ),
      backgroundColor: Colors.white,
      elevation: 8,

      ),
      body: Center(
        child: Text("We have two different types of images"
      ),
      ),
    );
  }
}
