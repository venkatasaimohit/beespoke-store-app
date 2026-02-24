import 'package:beespoke_store_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/preference_provider.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final pref = context.watch<PreferenceProvider>();
    final products = context.watch<ProductProvider>().products;

    /// ⭐ liked products
    List liked =
    products.where((p) => pref.likedIds.contains(p.id)).toList();

    /// ⭐ filtering
    if (selectedCategory != "All") {
      liked = liked.where((p) => p.category == selectedCategory).toList();
    }

    /// ⭐ categories
    final categories = ["All", ...{
      for (var p in products) p.category
    }];

    return Scaffold(
      appBar: AppBar(title: const Text("❤️ Liked Products")),

      body: Column(
        children: [
          /// ⭐ CATEGORY FILTER
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selectedCategory == cat,
                    onSelected: (_) {
                      setState(() => selectedCategory = cat);
                    },
                  ),
                );
              },
            ),
          ),

          /// ⭐ GRID
          Expanded(
            child: liked.isEmpty
                ? const Center(child: Text("No liked products"))
                : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .68,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: liked.length,
              itemBuilder: (_, i) {
                final product = liked[i];

                return Dismissible(
                  key: Key(product.id.toString()),

                  /// ⭐ swipe to remove
                  onDismissed: (_) {
                    pref.dislike(product.id);
                  },

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black.withOpacity(.08),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(product.image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "₹${product.price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}