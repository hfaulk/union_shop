import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/helpers/search_helper.dart';
import 'package:union_shop/models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchHelper _helper = SearchHelper();
  List<Product> _results = [];

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
        child: Column(children: [
          const Center(
              child: Text('SEARCH OUR SITE',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
              onChanged: (v) async {
                final r = await _helper.search(v);
                setState(() => _results = r);
              },
            ),
          ),
          const SizedBox(height: 12),
          if (_results.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.separated(
                itemCount: _results.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (c, i) {
                  final p = _results[i];
                  final original = '£${(p.price / 100).toStringAsFixed(2)}';
                  final discounted = p.discountedPrice != null
                      ? '£${(p.discountedPrice! / 100).toStringAsFixed(2)}'
                      : null;
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    leading: p.imageUrl.isNotEmpty
                        ? Image.asset(p.imageUrl,
                            width: 48, height: 48, fit: BoxFit.cover)
                        : null,
                    title: Text(p.title, style: const TextStyle(fontSize: 14)),
                    subtitle: discounted != null
                        ? Row(children: [
                            Text(original,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 12)),
                            const SizedBox(width: 8),
                            Text(discounted,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ])
                        : Text(original,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                    onTap: () {
                      Navigator.pushNamed(context, '/product/${p.id}');
                    },
                  );
                },
              ),
            ),
        ]),
      ),
    );
  }
}
