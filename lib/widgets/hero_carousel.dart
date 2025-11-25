import 'package:flutter/material.dart';
import '../models/hero_slide.dart';

class HeroCarousel extends StatefulWidget {
  final List<HeroSlide> slides;
  const HeroCarousel({Key? key, this.slides = const []}) : super(key: key);

  @override
  _HeroCarouselState createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;

  final List<HeroSlide> _sample = const [
    HeroSlide(
      image: 'assets/images/hero1.jpg',
      title: 'Essential Range - Over 20% OFF!',
      description:
          'Over 20% off our Essential Range. Come and grab yours while stock lasts!',
      buttonText: 'BROWSE COLLECTION',
      routeOrUrl: '/collections',
    ),
    HeroSlide(
      image: 'assets/images/hero2.jpg',
      title: 'New Arrivals',
      description: 'Check out our new range for the season.',
      buttonText: 'SHOP NOW',
      routeOrUrl: '/products',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Minimal placeholder UI for incremental development.
    return const SizedBox(
      height: 420,
      child: Center(
        child: Text(
          'HeroCarousel placeholder',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
