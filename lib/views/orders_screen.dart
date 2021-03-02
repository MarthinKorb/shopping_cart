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
      body: ordersProvider.orders.length > 0
          ? ListView.builder(
              itemCount: ordersProvider.orders.length,
              itemBuilder: (context, index) => OrderWidget(
                order: ordersProvider.orders[index],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/info.png', height: 120),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Você não tem pedidos.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
