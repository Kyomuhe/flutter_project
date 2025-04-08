import 'package:flutter/material.dart';

// Modified RatingWidget
class RatingWidget extends StatelessWidget {
  final int rating;

  const RatingWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Use only needed space
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 12, // Smaller stars
          color: index < rating ? const Color(0xFF3B82F6) : Colors.grey[300],
        );
      }),
    );
  }
}