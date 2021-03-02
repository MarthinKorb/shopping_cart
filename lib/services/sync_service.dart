import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';

import 'database_service.dart';

class SyncService {
  final BuildContext context;

  SyncService({@required this.context});

  int inserted = 0;

  Future<bool> sincronizaDados() async {
    try {
      ProductsProvider productsProvider = Provider.of(context, listen: false);

      await DatabaseService.deleteAll('Product');

      List<Product> dadosAPI = await productsProvider.loadList();

      for (var product in dadosAPI) {
        inserted = await DatabaseService.insert('Product', product.toMap());
      }

      // Navigator.of(context).pushReplacementNamed(AppRoutes.SYNC_PAGE);
      if (inserted > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
