import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/utils/app_routes.dart';
import 'package:shop_/widgets/app_drawer.dart';
import 'package:shop_/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider = Provider.of(context);
    final productsList = Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manutenção de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: productsList.isNotEmpty
          ? ListView.builder(
              itemCount: productsProvider.itemsCount,
              itemBuilder: (context, index) => Column(
                    children: [
                      ProductItem(product: productsList[index]),
                      Divider(),
                    ],
                  ))
          : Center(
              child: Text('Nenhum produto cadastrado!'),
            ),
    );
  }
}
