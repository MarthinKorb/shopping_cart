import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<dynamic, CartItem> _items = {};

  Map<dynamic, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  bool isCartEmpty() => _items.length == 0;

  bool isItemInCart(dynamic id) {
    return _items.containsKey(id.toString());
  }

  void addItemInCart(Product product) {
    if (_items.containsKey(product.id.toString())) {
      _items.update(
        product.id.toString(),
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: product.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
        () => CartItem(
          id: Random().nextDouble(),
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(dynamic productId) {
    _items.remove(productId.toString());
    notifyListeners();
  }

  void removeSingleItem(dynamic productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity == 1) {
      _items.remove(productId.toString());
    } else {
      _items.update(
        productId.toString(),
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
