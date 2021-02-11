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

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
// bool _showFavoriteOnly = false;

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

//  List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//   return [..._items];
