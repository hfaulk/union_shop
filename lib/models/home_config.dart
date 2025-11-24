class HomeConfig {
  final String heroTitle;
  final String heroDescription;
  final String heroCollectionId;
  final List<String> featuredCollectionIds;

  HomeConfig({
    required this.heroTitle,
    required this.heroDescription,
    required this.heroCollectionId,
    required this.featuredCollectionIds,
  });

  factory HomeConfig.fromJson(Map<String, dynamic> json) {
    final hero = json['hero'] as Map<String, dynamic>? ?? {};
    return HomeConfig(
      heroTitle: hero['title']?.toString() ?? '',
      heroDescription: hero['description']?.toString() ?? '',
      heroCollectionId: hero['collection']?.toString() ?? '',
      featuredCollectionIds: (json['featuredCollections'] as List?)
              ?.map((e) => e?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList() ??
          [],
    );
  }
}
