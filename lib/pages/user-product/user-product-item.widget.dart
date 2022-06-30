import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/user-product/edit-product.screen.dart';
import 'package:shop/providers/product/products.provider.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;
  const UserProductItem({Key? key, required this.title, required this.imageUrl, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () {
              Provider.of<Products>(context, listen: false).deleteProduct(id!);
            },
          ),
        ],
      ),
    );
  }
}
