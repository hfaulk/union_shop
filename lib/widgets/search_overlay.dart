import 'package:flutter/material.dart';
import 'package:union_shop/helpers/search_helper.dart';
import 'package:union_shop/models/product.dart';

class SearchOverlay extends StatefulWidget {
  final VoidCallback? onClose;
  const SearchOverlay({Key? key, this.onClose}) : super(key: key);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
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
                    return ListTile(
                      leading: p.imageUrl.isNotEmpty
                          ? Image.asset(p.imageUrl,
                              width: 40, height: 40, fit: BoxFit.cover)
                          : null,
                      title: Text(p.title),
                      trailing: Text('£${(p.price / 100).toStringAsFixed(2)}'),
                      onTap: () {},
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
