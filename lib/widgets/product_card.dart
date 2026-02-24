import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onTap;
  final String? pref;

  const ProductCard({
    super.key,
    required this.product,
    required this.onLike,
    required this.onDislike,
    required this.onTap,
    this.pref,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CachedNetworkImage(imageUrl: product.image, width: 50),
        title: Text(product.title, maxLines: 1),
        subtitle: Text("₹${product.price}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.thumb_up,
                  color: pref == 'like' ? Colors.green : Colors.grey),
              onPressed: onLike,
            ),
            IconButton(
              icon: Icon(Icons.thumb_down,
                  color: pref == 'dislike' ? Colors.red : Colors.grey),
              onPressed: onDislike,
            ),
          ],
        ),
      ),
    );
  }
}