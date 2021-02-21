import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({this.order});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy - hh:mm').format(widget.order.date);
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total}'),
            subtitle: Text(formattedDate),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 25.0) + 10,
              child: ListView(
                children: widget.order.products
                    .map(
                      (product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              product.title.split(" ").first,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              '${product.quantity}x R\$ ${product.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
