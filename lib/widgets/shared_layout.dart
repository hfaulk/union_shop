import 'package:flutter/material.dart';

class SharedLayout extends StatelessWidget {
  final Widget body;
  const SharedLayout({super.key, required this.body});

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void _placeholderCallbackForButtons() {
    // Intentional no-op placeholder to match main.dart behavior for unimplemented buttons
  }

  @override
  Widget build(BuildContext context) {
    // small scaffold with top sale banner + body area
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header (banner + main header)
            Container(
              height: 140,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _navigateToHome(context);
                            },
                            child: Image.network(
                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                              height: 18,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  width: 18,
                                  height: 18,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {},
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                        value: 'Home', child: Text('Home')),
                                    PopupMenuItem(
                                      // Shop: show a small inline submenu (chevron) to open categories
                                      child: Row(
                                        children: [
                                          const Text('Shop'),
                                          const Spacer(),
                                          // small chevron button that opens a secondary popup
                                          PopupMenuButton<String>(
                                            icon: const Icon(
                                                Icons.chevron_right,
                                                size: 18),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                  value: 'Clothing',
                                                  child: Text('Clothing')),
                                              const PopupMenuItem(
                                                  value: 'Merchandise',
                                                  child: Text('Merchandise')),
                                              const PopupMenuItem(
                                                  value: 'Halloween',
                                                  child: Text('Halloween')),
                                              const PopupMenuItem(
                                                  value:
                                                      'Signature & Essential Range',
                                                  child: Text(
                                                      'Signature & Essential Range')),
                                              const PopupMenuItem(
                                                  value:
                                                      'Portsmouth City Collection',
                                                  child: Text(
                                                      'Portsmouth City Collection')),
                                              const PopupMenuItem(
                                                  value: 'Pride Collection',
                                                  child:
                                                      Text('Pride Collection')),
                                              const PopupMenuItem(
                                                  value: 'Graduation',
                                                  child: Text('Graduation')),
                                            ],
                                            onSelected: (sub) {
                                              // placeholder handler for category selection
                                              _placeholderCallbackForButtons();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                        value: 'The Print Shack',
                                        child: Text('The Print Shack')),
                                    const PopupMenuItem(
                                        value: 'SALE!', child: Text('SALE!')),
                                    const PopupMenuItem(
                                        value: 'Collections',
                                        child: Text('Collections')),
                                    const PopupMenuItem(
                                        value: 'Collection Page',
                                        child: Text('Collection Page')),
                                    const PopupMenuItem(
                                        value: 'About', child: Text('About')),
                                  ],
                                  onSelected: (value) {
                                    if (value == 'Home') {
                                      _navigateToHome(context);
                                    } else if (value == 'Collections') {
                                      Navigator.pushNamed(
                                          context, '/collections');
                                    } else if (value == 'Collection Page') {
                                      Navigator.pushNamed(
                                          context, '/collection', arguments: {
                                        'title': 'Autumn Favourites'
                                      });
                                    } else if (value == 'About') {
                                      _navigateToAbout(context);
                                    } else {
                                      _placeholderCallbackForButtons();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content area (preserve SafeArea)
            SafeArea(child: body),

            // Footer
            // Footer — opening hours only (incremental change)
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Opening Hours',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text('(Term Time)',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  SizedBox(height: 6),
                  Text('Monday - Friday 9am - 4pm',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Text('(Outside of Term Time / Consolidation Weeks)',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  SizedBox(height: 6),
                  Text('Monday - Friday 9am - 3pm',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Text('Purchase online 24/7',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 28),

                  // Help and Information
                  Text('Help and Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: _placeholderCallbackForButtons,
                    child: const Text('Search',
                        style: TextStyle(
                            color: Color(0xFF4d2963),
                            decoration: TextDecoration.underline)),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: _placeholderCallbackForButtons,
                    child: const Text('Terms & Conditions of Sale Policy',
                        style: TextStyle(
                            color: Color(0xFF4d2963),
                            decoration: TextDecoration.underline)),
                  ),

                  SizedBox(height: 28),
                  // Latest Offers (newsletter signup)
                  Text('Latest Offers',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 12),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, letterSpacing: 1.2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('SUBSCRIBE'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
