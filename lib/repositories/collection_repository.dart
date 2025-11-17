import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:union_shop/models/collection.dart';

abstract class CollectionRepository {
  Future<List<Collection>> fetchAll();
  Future<Collection?> fetchById(String id);
}

class AssetCollectionRepository implements CollectionRepository {
  final String assetPath;

  /// Create a repository that reads collections from a JSON asset.
  /// Default path: assets/data/collections.json
  AssetCollectionRepository({this.assetPath = 'assets/data/collections.json'});

  @override
  Future<List<Collection>> fetchAll() async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = jsonDecode(raw);
      if (data is List) {
        return data
            .map((e) => Collection.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      // swallow and return empty list on error — caller can handle empty state
      return [];
    }
  }

  @override
  Future<Collection?> fetchById(String id) async {
    final all = await fetchAll();
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
