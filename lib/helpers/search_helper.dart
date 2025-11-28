import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

class SearchHelper {
  final ProductRepository repo;
  SearchHelper({ProductRepository? repository})
      : repo = repository ?? AssetProductRepository();

  Future<List<Product>> search(String query) async {
    if (query.trim().isEmpty) return [];
    final all = await repo.fetchAll();
    final q = query.toLowerCase();
    return all
        .where((p) =>
            p.title.toLowerCase().contains(q) || p.id.toLowerCase().contains(q))
        .toList();
  }
}
