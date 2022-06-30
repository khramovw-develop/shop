import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/user-product/edit-product.screen.dart';
import 'package:shop/pages/user-product/user-product-item.widget.dart';
import 'package:shop/widgets/app-drawer.widget.dart';

import '../../providers/product/products.provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = 'user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(EditProductScreen.routeName),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.getAll.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserProductItem(
                title: productsData.getAll[i].title,
                imageUrl: productsData.getAll[i].imageUrl,
                id: productsData.getAll[i].id,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
