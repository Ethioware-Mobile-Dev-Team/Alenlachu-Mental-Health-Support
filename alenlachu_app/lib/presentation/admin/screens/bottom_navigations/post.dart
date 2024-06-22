import 'package:flutter/material.dart';

class AdminPostPage extends StatefulWidget {
  const AdminPostPage({super.key});

  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Post Page"),
      ),
    );
  }
}
