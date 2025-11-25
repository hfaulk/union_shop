import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';

// File-backed test repository (top-level)
class FileCollectionRepository implements CollectionRepository {
  final String path;
  FileCollectionRepository(this.path);

  @override
  Future<List<Collection>> fetchAll() async {
    final raw = File(path).readAsStringSync();
    final data = json.decode(raw) as List<dynamic>;
    return data
        .map((e) => Collection.fromJson(e as Map<String, dynamic>))
        .toList();
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

void main() {
  group('File-backed CollectionRepository (test)', () {
    final repo = FileCollectionRepository('assets/data/collections.json');

    test('fetchAll returns non-empty list', () async {
      final all = await repo.fetchAll();
      expect(all, isNotEmpty);
    });

    test('fetchById returns known collection', () async {
      final c = await repo.fetchById('autumn');
      expect(c, isNotNull);
      expect(c!.id, equals('autumn'));
      expect(c.title, contains('Autumn'));
    });
  });
}
