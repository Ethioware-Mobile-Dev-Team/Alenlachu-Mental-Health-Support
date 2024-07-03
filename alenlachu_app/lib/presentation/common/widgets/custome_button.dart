import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final double width;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.name,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(name),
      ),
    );
  }
}
