import 'package:flutter/material.dart';
import 'package:union_shop/helpers/search_helper.dart';
import 'package:union_shop/models/product.dart';

class SearchOverlay extends StatefulWidget {
  final VoidCallback? onClose;
  const SearchOverlay({super.key, this.onClose});

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  String query = '';
  final SearchHelper _helper = SearchHelper();
  List<Product> _results = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            Row(children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Search'),
                  onChanged: (v) async {
                    query = v;
                    final r = await _helper.search(v);
                    setState(() => _results = r);
                  },
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.close), onPressed: widget.onClose),
            ]),
            if (_results.isNotEmpty)
              Expanded(
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      leading: p.imageUrl.isNotEmpty
                          ? Image.asset(p.imageUrl,
                              width: 44, height: 44, fit: BoxFit.cover)
                          : null,
                      title:
                          Text(p.title, style: const TextStyle(fontSize: 14)),
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
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/product/${p.id}');
                      },
                    );
                  },
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
