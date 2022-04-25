import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart/cart.provider.dart';
import 'grid-view-products-builder.widget.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() => selectedValue == FilterOptions.Favorites ? _showOnlyFavorites = true : _showOnlyFavorites = false);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites),
              const PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, __) => Badge(
              position: BadgePosition.topEnd(top: 3, end: 6),
              animationDuration: const Duration(milliseconds: 200),
              animationType: BadgeAnimationType.scale,
              borderSide: const BorderSide(color: Colors.white),
              badgeContent: Text('${cart.itemCount}', style: const TextStyle(color: Colors.white)),
              showBadge: cart.itemCount > 0,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: GridViewProductsBuilder(showFavorites: _showOnlyFavorites),
    );
  }
}
