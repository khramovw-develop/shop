import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart/cart.provider.dart';

class CartItemBuilder extends StatelessWidget {
  final CartItem cart;

  const CartItemBuilder({Key? key, required this.cart}) : super(key: key);

  @override
  Dismissible build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => buildShowDialog(context),
      onDismissed: (_) => Provider.of<Cart>(context, listen: false).removeItem(cart.productId),
      child: buildCard(),
    );
  }

  Future<bool?> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Are you sure?',
          textAlign: TextAlign.center,
        ),
        content: const Text('Do you want to remove the item from the cart?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
  }

  Card buildCard() {
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
