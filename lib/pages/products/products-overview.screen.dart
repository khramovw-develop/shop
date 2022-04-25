import 'package:flutter/material.dart';
import '../../widgets/badge.widget.dart';
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
          const KBadge(),
        ],
      ),
      body: GridViewProductsBuilder(showFavorites: _showOnlyFavorites),
    );
  }
}
