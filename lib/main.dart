import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/utils/app_routes.dart';
import 'package:shop_/views/product_detail_screen.dart';

import 'views/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'RobotoSlab',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
