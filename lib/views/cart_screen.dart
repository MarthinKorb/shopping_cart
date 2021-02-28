import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/cart_provider.dart';
import 'package:shop_/providers/orders_provider.dart';
import 'package:shop_/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final OrdersProvider ordersProvider =
        Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(14),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    elevation: 6,
                    label: Text(
                      'R\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: FlatButton(
                      child: Text('COMPRAR'),
                      textColor: Colors.white,
                      onPressed: () {
                        if (!cartProvider.isCartEmpty()) {
                          ordersProvider.addOrder(cart: cartProvider);
                          cartProvider.clearCart();
                        } else {
                          showDialog(
                            context: context,
                            child: Container(
                              child: AlertDialog(
                                title: Text(
                                  'Aviso',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                content: Text(
                                  'Não é possível efetuar uma compra sem pelo menos um item no carrinho.',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: cartProvider.isCartEmpty()
                ? EmptyCartIWarning()
                : ListView.builder(
                    itemCount: cartProvider.itemCount,
                    itemBuilder: (context, index) {
                      return CartItemWidget(cartItem: cartItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class EmptyCartIWarning extends StatelessWidget {
  const EmptyCartIWarning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          color: Theme.of(context).primaryColor,
          size: 60,
        ),
        SizedBox(height: 10),
        Text(
          'Seu carrinho está vazio...',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
