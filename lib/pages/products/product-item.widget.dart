import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product/product.provider.dart';
import '../../providers/cart/cart.provider.dart';
import '../../providers/product/product.provider.dart';

import 'product-detail.screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: Consumer<Product>(
            builder: (ctx, p, child) => IconButton(
              icon: Icon(p.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () => p.toggleFavoriteStatus(),
            ),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: Consumer<Cart>(
              builder: (ctx, cart, child) => IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () => cart.addItem(product.id, product.price, product.title),
                  )),
        ),
      ),
    );
  }
}
