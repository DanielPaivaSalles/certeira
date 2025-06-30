import 'package:flutter/material.dart';

class CustomSelectionTitle extends StatelessWidget {
  final String text;

  const CustomSelectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
