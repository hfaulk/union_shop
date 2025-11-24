import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:union_shop/models/home_config.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

class HomeData {
  final String heroTitle;
  final String heroDescription;
  final Collection? heroCollection;
  final Map<Collection, List<Product>> featured;

  HomeData({
    required this.heroTitle,
    required this.heroDescription,
    required this.heroCollection,
    required this.featured,
  });
}

class HomeRepository {
  final String assetPath;
  final CollectionRepository collectionRepo;
  final ProductRepository productRepo;

  HomeRepository({
    this.assetPath = 'assets/data/home_config.json',
    required this.collectionRepo,
    required this.productRepo,
  });

  Future<HomeData?> load() async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = jsonDecode(raw);
      if (data is List && data.isNotEmpty) {
        final cfg = HomeConfig.fromJson(data.first as Map<String, dynamic>);

        // hero collection
        final heroCollection = cfg.heroCollectionId.isNotEmpty
            ? await collectionRepo.fetchById(cfg.heroCollectionId)
            : null;

        final Map<Collection, List<Product>> featured = {};
        for (final id in cfg.featuredCollectionIds) {
          final collection = await collectionRepo.fetchById(id);
          if (collection == null) continue;
          final products = await productRepo.fetchByCollection(collection.id);
          // take first two
          featured[collection] = products.take(2).toList();
        }

        return HomeData(
          heroTitle: cfg.heroTitle,
          heroDescription: cfg.heroDescription,
          heroCollection: heroCollection,
          featured: featured,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
