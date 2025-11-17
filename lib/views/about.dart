import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Header/navigation is provided by SharedLayout; keep this page focused on content.

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 24),
              Text(
                'About the Union Shop',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'This is the about page. Add real content here describing the shop, policies, contact info, or other details.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
