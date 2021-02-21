import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop_/models/order.dart';
import 'package:shop_/providers/cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  int get itemsCount => _orders.length;

  void addOrder({@required CartProvider cart}) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble(),
        total: double.tryParse(cart.totalAmount.toStringAsFixed(2)),
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
