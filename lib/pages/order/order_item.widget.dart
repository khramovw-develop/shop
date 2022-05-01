import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/orders/orders.provider.dart';

class OrderItemBuilder extends StatelessWidget {
  final OrderItem order;

  const OrderItemBuilder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {
              // Provider.of<Orders>(context, listen: false).removeOrder(order.id);
            },
          ),
        ),
      ]),
    );
  }
}
