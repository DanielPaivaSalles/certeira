import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final void Function() onTap;

  const CustomButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    if (widget.isSelected) {
      backgroundColor = Colors.white70;
    } else if (isHovering) {
      backgroundColor = Colors.grey;
    } else {
      backgroundColor = Colors.black87;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
