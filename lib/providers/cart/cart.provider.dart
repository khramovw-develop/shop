import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) => total += cartItem.price * cartItem.quantity);
    return total;
  }

  /* add product to cart */
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                productId: existingCartItem.productId,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                productId: productId,
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  /* remove product from cart */
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /* Remove product */
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    CartItem prod = items[productId]!;

    if (items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                productId: existingCartItem.productId,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  /* clear cart */
  void clear() {
    _items = {};
    notifyListeners();
  }
}

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}
