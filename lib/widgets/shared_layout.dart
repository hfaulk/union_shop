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
          // Main header row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Logo
                GestureDetector(
                  onTap: () {},
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 40,
                        height: 40,
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      );
                    },
                  ),
                ),

                const Spacer(),

                // Icon group (placeholders for now)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.grey),
                      onPressed: () {}, // placeholder
                      tooltip: 'Search',
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.person_outline, color: Colors.grey),
                      onPressed: () {}, // placeholder
                      tooltip: 'Account',
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined,
                          color: Colors.grey),
                      onPressed: () {}, // placeholder
                      tooltip: 'Cart',
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.grey),
                      onPressed:
                          () {}, // placeholder (menu logic will be added later)
                      tooltip: 'Menu',
                    ),
                  ],
                ),
              ],
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
