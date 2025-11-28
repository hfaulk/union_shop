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
        // cfg.featuredCollections is a map collectionId -> list of productIds
        for (final entry in cfg.featuredCollections.entries) {
          final collectionId = entry.key;
          final productIds = entry.value;
          final collection = await collectionRepo.fetchById(collectionId);
          if (collection == null) continue;

          final List<Product> chosen = [];
          // If product ids are specified, try to load those exact products in order
          if (productIds.isNotEmpty) {
            for (final pid in productIds) {
              final p = await productRepo.fetchById(pid);
              if (p != null) chosen.add(p);
              if (chosen.length >= 2) break;
            }
          }

          // Fallback: if no products specified or found, choose lowest-priced products from the collection
          if (chosen.isEmpty) {
            final products = await productRepo.fetchByCollection(collection.id);
            int effectivePrice(Product p) =>
                (p.discount && p.discountedPrice != null)
                    ? p.discountedPrice!
                    : p.price;
            products
                .sort((a, b) => effectivePrice(a).compareTo(effectivePrice(b)));
            chosen.addAll(products.take(2).toList());
          }

          featured[collection] = chosen;
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
      // Fallback when asset loading fails (tests / offline): build minimal HomeData
      final cols = await collectionRepo.fetchAll();
      if (cols.isEmpty) return null;
      final first = cols.first;
      final products = await productRepo.fetchByCollection(first.id);
      final chosen = products.take(2).toList();
      return HomeData(
        heroTitle: 'Essential Range - Over 20% OFF!',
        heroDescription: '',
        heroCollection: first,
        featured: {first: chosen},
      );
    }
  }
}
