import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/services/database_service.dart';
import 'package:shop_/shared/utils/app_routes.dart';
import 'package:shop_/widgets/app_drawer.dart';
import 'package:shop_/widgets/info_empty_list.dart';
import 'package:shop_/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  Future<List> getOrders() async {
    var data = await DatabaseService.query('Order');
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manutenção de Produtos'),
        actions: [
          IconButton(
              icon: Icon(Icons.do_disturb_alt_sharp),
              onPressed: () => getOrders()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Product>>(
        future: Provider.of<ProductsProvider>(context).loadProductsFromDB(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return InfoEmptyList(
              message: 'Nenhum produto cadastrado',
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => Column(
              children: [
                ProductItem(product: snapshot.data[index]),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
