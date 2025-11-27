import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/widgets/hero_carousel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 400, width: double.infinity, child: HeroCarousel()),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(children: [
                Container(
                    height: 190,
                    color: Colors.grey[200],
                    child: const Center(child: Text('Featured Collection 1'))),
                const SizedBox(height: 20),
                Container(
                    height: 190,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Featured Collection 2'))),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
