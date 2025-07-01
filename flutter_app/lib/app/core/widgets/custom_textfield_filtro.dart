import 'package:flutter/material.dart';

class CustomTextFieldFiltro extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextFieldFiltro({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
