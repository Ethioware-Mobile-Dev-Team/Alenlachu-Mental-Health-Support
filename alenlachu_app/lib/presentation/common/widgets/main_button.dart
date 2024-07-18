import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double width, height;
  final Widget child;
  final VoidCallback onPressed;

  const MainButton(
      {super.key,
      required this.child,
      this.width = 200,
      this.height = 50,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
