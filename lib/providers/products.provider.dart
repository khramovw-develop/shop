import 'package:flutter/cupertino.dart';

import '../pages/products/products.data.dart';
import 'product.provider.dart';

class Products with ChangeNotifier {
  final List<Product> _items = productList;

  var _showFavoritesOnly = false;

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  List<Product> get favoritesOnlyList => _items.where((prodItem) => prodItem.isFavorite).toList();

  List<Product> get items => _showFavoritesOnly ? favoritesOnlyList : [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
