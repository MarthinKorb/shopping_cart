import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.image)),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () async {
                ProductsProvider productsProvider =
                    Provider.of(context, listen: false);
                productsProvider.removeProduct(product);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Produto removido com sucesso.')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
