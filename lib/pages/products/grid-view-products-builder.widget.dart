import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/products/product-item.widget.dart';
import 'package:shop/providers/product/product.provider.dart';

import '../../providers/product/products.provider.dart';

class GridViewProductsBuilder extends StatelessWidget {
  final bool showFavorites;
  const GridViewProductsBuilder({required this.showFavorites, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final List<Product> products = showFavorites ? productData.getFavorites : productData.getAll;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
        key: ValueKey(products[i].id),
        value: products[i],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
