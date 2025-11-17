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
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text('About us',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800])),
              ),
              const SizedBox(height: 28),

              Text('Welcome to the Union Shop!',
                  style: TextStyle(fontSize: 18, color: Colors.grey[800])),
              const SizedBox(height: 18),

              Text(
                'We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive ',
                style: TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.grey[700]),
              ),
              // small underlined link-style text for 'personalisation service'
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 12.0),
                child: Text('personalisation service!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        decoration: TextDecoration.underline)),
              ),

              const SizedBox(height: 6),
              Text(
                  'All online purchases are available for delivery or instore collection!',
                  style: TextStyle(
                      fontSize: 16, height: 1.6, color: Colors.grey[700])),
              const SizedBox(height: 18),

              Text(
                'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at ',
                style: TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.grey[700]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 18.0),
                child: Text('hello@upsu.net',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        decoration: TextDecoration.underline)),
              ),

              const SizedBox(height: 8),
              Text('Happy shopping!',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              const SizedBox(height: 18),
              Text('The Union Shop & Reception Team',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
