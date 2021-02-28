import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/views/products_overview_screen.dart';
import 'package:shop_/widgets/info_empty_list.dart';
import 'package:shop_/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorite;
  final bool showCompactGrid;

  const ProductGrid({Key key, this.showOnlyFavorite, this.showCompactGrid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Provider.of<ProductsProvider>(context).loadProductsFromDB(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingInfo(context);
        }

        if (snapshot.hasError) {
          return InfoEmptyList(
            message: 'Erro ao carregar os dados',
            iconData: Icons.error_outline,
          );
        }

        List<Product> loadedProducts = showOnlyFavorite
            ? snapshot.data.where((p) => p.isFavorite == 1).toList()
            : snapshot.data;

        if (showOnlyFavorite) {
          return InfoEmptyList(
            message: 'Nenhum produto na lista de favoritos',
            iconData: Icons.favorite_border_outlined,
          );
        }

        return loadedProducts.length == 0 && !showOnlyFavorite
            ? InfoEmptyList(
                message: 'Nenhum produto cadastrado',
                iconData: Icons.wysiwyg_outlined,
              )
            : GridView.builder(
                itemCount: loadedProducts.length,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: showCompactGrid ? 2 : 1,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: loadedProducts[index],
                    child: ProductGridItem(),
                  );
                },
              );
      },
    );
  }

  Center _buildEmptyListInfo(BuildContext context) {
    return Center(
      child: Text(
        'Nenhum produto na lista de favoritos',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Container _buildLoadingInfo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.black12,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          SizedBox(height: 20),
          Text(
            'Carregando...',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
