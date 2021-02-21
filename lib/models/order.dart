import 'package:shop_/providers/cart_provider.dart';

class Order {
  final dynamic id;
  final double total;
  final List<CartItem> products;
  final DateTime date;
  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}
