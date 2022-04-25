import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart/cart.provider.dart';

class KBadge extends StatelessWidget {
  const KBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (_, cart, __) => Badge(
        position: BadgePosition.topEnd(top: 3, end: 6),
        animationDuration: const Duration(milliseconds: 200),
        animationType: BadgeAnimationType.scale,
        borderSide: const BorderSide(color: Colors.white),
        badgeContent: Text('${cart.itemCount}', style: const TextStyle(color: Colors.white)),
        showBadge: cart.itemCount > 0,
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
