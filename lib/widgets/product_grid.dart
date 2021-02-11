import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorite;

  const ProductGrid({Key key, this.showOnlyFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider provider = Provider.of<ProductsProvider>(context);

    final List<Product> loadedProducts =
        showOnlyFavorite ? provider.favoriteItems : provider.items;

    return loadedProducts.length == 0
        ? Center(child: Text('Nenhum produto favoritado'))
        : GridView.builder(
            itemCount: loadedProducts.length,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: loadedProducts[index],
                child: ProductItem(),
              );
            },
          );
  }
}
