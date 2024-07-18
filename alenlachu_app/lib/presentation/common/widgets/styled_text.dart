import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String lable;
  final double size;
  final Color color;
  final bool isBold;
  final TextOverflow overflow;
  final int? maxLines;

  const StyledText({
    super.key,
    required this.lable,
    this.size = 18,
    this.color = Colors.white,
    this.isBold = true,
    this.overflow = TextOverflow.visible,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
