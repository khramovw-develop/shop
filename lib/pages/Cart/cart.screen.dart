import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart/cart.provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
              margin: const EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Total', style: TextStyle(fontSize: 20.0)),
                    const Spacer(),
                    Chip(
                      label: Text(cart.totalAmount.toStringAsFixed(2), style: const TextStyle(color: Colors.white)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    TextButton(
                      child: Text('ORDER NOW', style: TextStyle(fontSize: 20.0, color: Theme.of(context).colorScheme.primary)),
                      onPressed: () {},
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
