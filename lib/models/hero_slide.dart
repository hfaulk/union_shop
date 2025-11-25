class HeroSlide {
  final String image; // asset path
  final String title;
  final String description;
  final String buttonText;
  final String routeOrUrl;

  const HeroSlide({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.routeOrUrl,
  });

  factory HeroSlide.fromJson(Map<String, dynamic> json) => HeroSlide(
        image: json['image'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        buttonText: json['buttonText'] as String? ?? '',
        routeOrUrl: json['routeOrUrl'] as String? ?? '',
      );
}
