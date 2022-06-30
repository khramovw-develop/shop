import 'package:flutter/cupertino.dart';

import '../../pages/products/products.data.dart';
import 'product.provider.dart';

class Products with ChangeNotifier {
  final List<Product> _items = productList;

  List<Product> get getFavorites => _items.where((prodItem) => prodItem.isFavorite).toList();

  List<Product> get getAll => [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.insert(0, newProduct);
    // _items.add(product);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
