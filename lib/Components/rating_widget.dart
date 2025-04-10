import 'package:flutter/material.dart';

// Modified RatingWidget with customizable color
class RatingWidget extends StatelessWidget {
  final int rating;
  final Color color;

  const RatingWidget({
    Key? key, 
    required this.rating, 
    this.color = const Color(0xFF3B82F6), // Default blue color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Use only needed space
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 12, // Smaller stars
          color: index < rating ? color : Colors.grey[300],
        );
      }),
    );
  }
}