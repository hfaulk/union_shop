class HomeConfig {
  final String heroTitle;
  final String heroDescription;
  final String heroCollectionId;
  final Map<String, List<String>> featuredCollections;

  HomeConfig({
    required this.heroTitle,
    required this.heroDescription,
    required this.heroCollectionId,
    required this.featuredCollections,
  });

  factory HomeConfig.fromJson(Map<String, dynamic> json) {
    final hero = json['hero'] as Map<String, dynamic>? ?? {};
    // featuredCollections is expected to be an object mapping collectionId -> [productId,...]
    final rawFeatured = json['featuredCollections'] as Map<String, dynamic>?;
    final Map<String, List<String>> featuredMap = {};
    if (rawFeatured != null) {
      rawFeatured.forEach((key, value) {
        if (value is List) {
          final ids = value
              .map((e) => e?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList();
          if (ids.isNotEmpty) featuredMap[key.toString()] = ids;
        }
      });
    }

    return HomeConfig(
      heroTitle: hero['title']?.toString() ?? '',
      heroDescription: hero['description']?.toString() ?? '',
      heroCollectionId: hero['collection']?.toString() ?? '',
      featuredCollections: featuredMap,
    );
  }
}
