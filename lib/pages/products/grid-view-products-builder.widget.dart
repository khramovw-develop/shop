import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/products/product-item.widget.dart';

import '../../providers/products.provider.dart';

class GridViewProductsBuilder extends StatelessWidget {
  const GridViewProductsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(product: products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
