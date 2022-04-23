import 'package:flutter/material.dart';
import 'package:shop/products/product-item.widget.dart';
import 'package:shop/products/product.model.dart';
import 'package:shop/products/products.data.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/product-overview';

  get configGridDelegate => const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      );

  final List<Product> loadedProduct = productList;

  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProduct.length,
        itemBuilder: (ctx, i) => ProductItem(product: loadedProduct[i]),
        gridDelegate: configGridDelegate,
      ),
    );
  }
}
