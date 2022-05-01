import 'package:flutter/material.dart';

class CartItemBuilder extends StatelessWidget {
  final cart;

  const CartItemBuilder({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$ ${cart.price}'),
              ),
            ),
          ),
          title: Text(cart.title),
          subtitle: Text('Total: \$ ${cart.price * cart.quantity}'),
          trailing: Text('${cart.quantity}x'),
        ),
      ),
    );
  }
}
