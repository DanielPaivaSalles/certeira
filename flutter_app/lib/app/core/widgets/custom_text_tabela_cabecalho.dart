import 'package:flutter/material.dart';

class CustomTextTabelaCabecalho extends StatelessWidget {
  final String text;

  const CustomTextTabelaCabecalho({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
