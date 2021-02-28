import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/cart_provider.dart';
import 'package:shop_/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({@required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cartProvider.removeItem(cartItem.productId),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text('Tem certeza?'),
              ],
            ),
            content: Text('Quer remover o item ${cartItem.title} do carrinho?'),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FlatButton(
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${cartItem.title} removido do carrinho.'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(
                    'Sim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  child: FlatButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: Text('R\$ ${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
            trailing: Text(
              '${cartItem.quantity}x',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
