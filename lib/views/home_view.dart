import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/widgets/hero_carousel.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 400, width: double.infinity, child: HeroCarousel()),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(children: [
                Container(
                    height: 190,
                    color: Colors.grey[200],
                    child: const Center(child: Text('Featured Collection 1'))),
                const SizedBox(height: 20),
                Container(
                    height: 190,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Featured Collection 2'))),
              ]),
            ),
            const SizedBox(height: 32),
            // Our Range heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: Text('OUR RANGE',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            // 2x2 collections grid (first 4 collections)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FutureBuilder<List<Collection>>(
                future: AssetCollectionRepository().fetchAll(),
                builder: (context, snapshot) {
                  final cols = snapshot.data ?? <Collection>[];
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: List.generate(4, (i) {
                      final c = i < cols.length ? cols[i] : null;
                      return GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/collections'),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(6)),
                          child: Stack(fit: StackFit.expand, children: [
                            if (c?.imageUrl != null)
                              (c!.imageUrl!.startsWith('assets/')
                                  ? Image.asset(c.imageUrl!, fit: BoxFit.cover)
                                  : Image.network(c.imageUrl!,
                                      fit: BoxFit.cover))
                            else
                              Container(color: Colors.grey[400]),
                            Container(color: Colors.black26),
                            Center(
                                child: Text(c?.title ?? 'Collection ${i + 1}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ]),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
