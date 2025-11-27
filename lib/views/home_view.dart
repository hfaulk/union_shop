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
            const SizedBox(height: 32),
            // Our Range heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: Text('OUR RANGE',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            // 2x2 collections grid (first 4 collections)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: List.generate(4, (i) {
                  return Container(
                    color: Colors.grey[350],
                    child: Center(
                        child: Text('Collection ${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
