import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/orders_provider.dart';
import 'package:shop_/widgets/app_drawer.dart';
import 'package:shop_/widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) => OrderWidget(
          order: ordersProvider.orders[index],
        ),
      ),
    );
  }
}
