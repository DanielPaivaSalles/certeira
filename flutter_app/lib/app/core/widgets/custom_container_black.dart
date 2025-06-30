import 'package:flutter/material.dart';

class CustomContainerBlack extends StatelessWidget {
  final Widget child;

  const CustomContainerBlack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
