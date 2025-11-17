import 'package:flutter/material.dart';

class SharedLayout extends StatelessWidget {
  final Widget body;
  const SharedLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    // very small scaffold so importing pages can switch to SharedLayout safely
    return Scaffold(
      body: SafeArea(child: body),
    );
  }
}
