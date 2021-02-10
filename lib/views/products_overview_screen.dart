import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts =
        Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      appBar: AppBar(title: Text('Minha Loja')),
      body: GridView.builder(
        itemCount: loadedProducts.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductItem(product: loadedProducts[index]);
        },
      ),
    );
  }
}
