import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/Cart/cart.screen.dart';
import 'package:shop/pages/products/product-detail.screen.dart';
import 'package:shop/providers/cart/cart.provider.dart';
import 'package:shop/providers/orders/orders.provider.dart';
import 'package:shop/providers/product/products.provider.dart';
import 'package:shop/pages/products/products-overview.screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Products>(create: (_) => Products()),
          ChangeNotifierProvider<Cart>(create: (_) => Cart()),
          ChangeNotifierProvider<Orders>(create: (_) => Orders()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildThemeData,
      initialRoute: ProductsOverviewScreen.routeName,
      routes: {
        ProductsOverviewScreen.routeName: (ctx) => const ProductsOverviewScreen(),
        ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        CartScreen.routeName: (ctx) => const CartScreen(),
      },
    );
  }

  ThemeData get buildThemeData {
    return ThemeData(
      fontFamily: 'Lato',
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ).copyWith(secondary: Colors.deepOrange),
    );
  }
}
