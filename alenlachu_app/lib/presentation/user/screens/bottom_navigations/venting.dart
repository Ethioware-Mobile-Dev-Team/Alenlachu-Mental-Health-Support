import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';

class VentingPage extends StatefulWidget {
  const VentingPage({super.key});

  @override
  State<VentingPage> createState() => _VentingPageState();
}

class _VentingPageState extends State<VentingPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: StyledText(
      lable: 'Coming Soon . . .',
      color: Colors.grey,
      size: 14,
    ));
  }
}
