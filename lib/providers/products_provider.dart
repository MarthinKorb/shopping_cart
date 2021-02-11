import 'package:flutter/cupertino.dart';
import 'package:shop_/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = List.generate(
    15,
    (index) => Product(
      id: index.toString(),
      title: 'Título $index',
      description: 'Título $index',
      price: 100,
      imageUrl:
          'https://images.madeiramadeira.com.br/product/images/64691864-furadeira-de-impacto-eletrica-16mm-5-8-makita-hp1640-110v10461-3226-1-600x600.jpg',
    ),
  );

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
