import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';

class CollectionsPage extends StatelessWidget {
  static const String routeName = '/collections';

  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Single hard-coded collection (Autumn Favourites) as requested.
    final items = [
      {
        'title': 'Autumn Favourites',
        'image':
            'https://shop.upsu.net/cdn/shop/products/GreenSweatshirtFinal_900x.png?v=1741965433'
      },
      {
        'title': 'Clothing',
        'image':
            'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal_900x.jpg?v=1742201957'
      },
      {
        'title': 'Graduation',
        'image':
            'https://shop.upsu.net/cdn/shop/collections/GradGrey_900x.jpg?v=1752234294'
      },
      {
        'title': 'Signature & Essential Range',
        'image':
            'https://shop.upsu.net/cdn/shop/files/Signature_T-Shirt_Indigo_Blue_2_900x.jpg?v=1758290534'
      }
    ];

    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Collections',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800])),
            ),
            const SizedBox(height: 28),

            // Grid of collection cards. shrinkWrap so it works inside the parent scroll view.
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    // placeholder navigation
                    Navigator.pushNamed(context, '/product');
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image takes remaining space so each card is square (grid childAspectRatio=1)
                        Expanded(
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        // Fixed-height title area to keep all cards equal-sized
                        Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text(
                            item['title']!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
