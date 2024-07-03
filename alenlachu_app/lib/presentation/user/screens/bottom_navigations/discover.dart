import 'package:alenlachu_app/presentation/common/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Discover',
      ),
      body: Center(
        child: Text('Discover Page'),
      ),
    );
  }
}
