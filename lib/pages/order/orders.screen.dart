import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/order/order_item.widget.dart';
import 'package:shop/widgets/app-drawer.widget.dart';

import '../../providers/orders/orders.provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orders orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItemBuilder(order: orderData.orders[i]),
      ),
    );
  }
}
