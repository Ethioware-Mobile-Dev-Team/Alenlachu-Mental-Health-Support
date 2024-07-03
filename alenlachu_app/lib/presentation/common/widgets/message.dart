import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
