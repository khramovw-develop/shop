import 'package:flutter/material.dart';

import 'grid-view-products-builder.widget.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/product-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyShop')),
      body: const GridViewProductsBuilder(),
    );
  }
}
