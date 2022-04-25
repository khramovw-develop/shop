import 'package:flutter/cupertino.dart';

import '../../pages/products/products.data.dart';
import 'product.provider.dart';

class Products with ChangeNotifier {
  final List<Product> _items = productList;

  List<Product> get getFavorites => _items.where((prodItem) => prodItem.isFavorite).toList();

  List<Product> get getAll => [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
