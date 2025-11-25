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
  int _current = 0;

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
    _controller.addListener(() {
      final page = (_controller.page ?? 0).round();
      if (page != _current) setState(() => _current = page);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = widget.slides.isNotEmpty ? widget.slides : _sample;
    return SizedBox(
      height: 420,
      child: PageView.builder(
        controller: _controller,
        itemCount: slides.length,
        itemBuilder: (context, index) {
          final s = slides[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(s.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[800])),
              Container(color: Colors.black.withOpacity(0.45)),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(s.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () {}, child: Text(s.buttonText)),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        slides.length,
                        (i) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                  color: i == _current
                                      ? Colors.white
                                      : Colors.white30,
                                  shape: BoxShape.circle),
                            )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
