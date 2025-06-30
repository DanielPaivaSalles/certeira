import 'package:flutter/material.dart';

class CustomContainerWhite extends StatelessWidget {
  final Widget child;

  const CustomContainerWhite({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
