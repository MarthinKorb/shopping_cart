import 'package:flutter/material.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = List.generate(
    10,
    (index) => Product(
      id: index.toString(),
      title: 'Título $index',
      description: 'Título $index',
      price: 100,
      imageUrl:
          'https://images.madeiramadeira.com.br/product/images/64691864-furadeira-de-impacto-eletrica-16mm-5-8-makita-hp1640-110v10461-3226-1-600x600.jpg',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minha Loja')),
      body: GridView.builder(
        itemCount: loadedProducts.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductItem(product: loadedProducts[index]);
        },
      ),
    );
  }
}
