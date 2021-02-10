import 'package:flutter/material.dart';

import 'package:shop_/models/product.dart';
import 'package:shop_/providers/couter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          RaisedButton(
            child: Center(
              child: Icon(Icons.add),
            ),
            onPressed: () {
              setState(() {
                CounterProvider.of(context).state.increment();
              });
              print(CounterProvider.of(context).state.value);
            },
          ),
          Text(CounterProvider.of(context).state.value.toString()),
          RaisedButton(
            child: Center(
              child: Icon(Icons.remove),
            ),
            onPressed: () {
              setState(() {
                CounterProvider.of(context).state.decrement();
              });
              print(CounterProvider.of(context).state.value);
            },
          ),
        ],
      ),
    );
  }
}
