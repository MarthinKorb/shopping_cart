import 'package:flutter/foundation.dart';

class CartItem {
  final dynamic id;
  final dynamic productId;
  final String title;
  final int quantity;
  final dynamic price;
  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
