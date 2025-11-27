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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                    child: Image.network('https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854', height: 64),
                  ),
                  const SizedBox(height: 18),
                  const Text('Sign in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  const Text('Choose how you\'d like to sign in', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
