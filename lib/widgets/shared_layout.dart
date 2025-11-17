import 'package:flutter/material.dart';

class SharedLayout extends StatelessWidget {
  final Widget body;
  const SharedLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    // small scaffold with top sale banner + body area
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Top purple sale banner (commit 2 - minimal change)
          Container(
            width: double.infinity,
            color: const Color(0xFF4d2963),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
          ),

          // Main content area (preserve SafeArea)
          Expanded(
            child: SafeArea(child: body),
          ),
        ],
      ),
    );
  }
}
