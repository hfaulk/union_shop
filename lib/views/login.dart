import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: SizedBox(
            width: 360,
            height: 420,
            child: const Center(child: Text('Login page (placeholder)')),
          ),
        ),
      ),
    );
  }
}
