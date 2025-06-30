import 'package:flutter/material.dart';

class CustomTextTabelaTexto extends StatelessWidget {
  final String text;

  const CustomTextTabelaTexto({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 16));
  }
}
