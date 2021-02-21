import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/cart_provider.dart';
import 'package:shop_/providers/orders_provider.dart';
import 'package:shop_/providers/products_provider.dart';
import 'package:shop_/utils/app_routes.dart';
import 'package:shop_/views/cart_screen.dart';
import 'package:shop_/views/orders_screen.dart';
import 'package:shop_/views/product_detail_screen.dart';
import 'package:shop_/views/product_form_screen.dart';
import 'package:shop_/views/products_screen.dart';
import 'package:shop_/views/sync.dart';
import 'package:shop_/views/sync_page.dart';

import 'views/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
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
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.MY_ORDERS: (context) => OrdersScreen(),
          AppRoutes.PRODUCTS: (context) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormScreen(),
          AppRoutes.SYNC_PAGE: (context) => SyncPage(),
          AppRoutes.REAL_SYNC: (context) => RealSync(),
        },
      ),
    );
  }
}
