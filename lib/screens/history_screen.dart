import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/history_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';
import 'webview_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryProvider>();
    final products = context.read<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Browsing History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => context.read<HistoryProvider>().clear(),
          )
        ],
      ),
      body: history.items.isEmpty
          ? const Center(child: Text("No history yet"))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.items.length,
        itemBuilder: (_, i) {
          final item = history.items[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                /// open product again
                if (item.url.startsWith("product_")) {
                  final id = int.parse(item.url.split("_")[1]);
                  final product =
                  products.firstWhere((p) => p.id == id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                } else {
                  /// open external url
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewScreen(
                        url: item.url,
                        title: item.title,   // ⭐ ADD THIS
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),

                          /// ⭐ show URL
                          Text(
                            item.url,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.open_in_new)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}