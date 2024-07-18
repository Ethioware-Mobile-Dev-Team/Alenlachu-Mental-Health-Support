import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String lable;
  final double size;
  final Color color;
  final bool isBold;
  const StyledText(
      {super.key,
      required this.lable,
      this.size = 18,
      this.color = Colors.white,
      this.isBold = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
