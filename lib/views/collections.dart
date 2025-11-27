import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';

class CollectionsPage extends StatefulWidget {
  static const String routeName = '/collections';

  // Allow injecting a repository for tests; default uses bundled assets.
  final CollectionRepository? repo;

  const CollectionsPage({super.key, this.repo});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  static const int pageSize = 12;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final repoInstance = widget.repo ?? AssetCollectionRepository();

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

            // Load collections from the asset repository and show them in a grid
            FutureBuilder<List<Collection>>(
              future: repoInstance.fetchAll(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final collections = snap.data ?? [];
                if (collections.isEmpty) {
                  return const Center(child: Text('No collections yet'));
                }

                // Compute pagination slice for current page
                final totalPages = (collections.length + pageSize - 1) ~/ pageSize;
                final start = (currentPage - 1) * pageSize;
                final pagedCollections = collections.skip(start).take(pageSize).toList();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: pagedCollections.length,
                  itemBuilder: (context, index) {
                    final c = pagedCollections[index];
                    return InkWell(
                      onTap: () {
                        final slug = c.id;
                        Navigator.pushNamed(context, '/collections/$slug');
                      },
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                c.imageUrl ?? '',
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
                            Container(
                              height: 56,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text(
                                c.title,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
