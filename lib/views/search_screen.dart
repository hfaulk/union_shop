import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
        child: Column(
          children: const [
            Center(
                child: Text('SEARCH OUR SITE',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            SizedBox(height: 16),
            SizedBox(
                height: 48,
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search', border: OutlineInputBorder()))),
          ],
        ),
      ),
    );
  }
}
