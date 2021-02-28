import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_/services/database_service.dart';

class ProductsProvider with ChangeNotifier {
  static const String apiURL = 'https://fakestoreapi.com/products';
  final List<Product> _items = List<Product>();

  Future<List<Product>> loadList() async {
    try {
      _items.clear();
      final response = await http.get(apiURL);
      if (response.statusCode == 200) {
        var decodeJSON = jsonDecode(response.body);

        decodeJSON.forEach((item) {
          _items.add(Product.fromMap(item));
        });
        return _items;
      } else {
        print('A lista está vazia!');
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
    return _items;
  }

  Future<List<Product>> loadProductsFromDB() async {
    var records = await DatabaseService.query("Product");
    return List.generate(records.length, (i) {
      return Product(
        id: records[i]["id"],
        title: records[i]["title"],
        description: records[i]["description"],
        category: records[i]["category"],
        price: records[i]["price"],
        image: records[i]["image"],
        isFavorite: records[i]["isFavorite"] ?? 0,
      );
    });
  }

  void removeProduct(Product product) async {
    await DatabaseService.deleteProductById('product', product.id.toString());
    _items
      ..clear()
      ..addAll([...await loadProductsFromDB()]);
    notifyListeners();
  }

  Future<bool> updateProduct(Product product) async {
    _items
      ..clear()
      ..addAll([...await loadProductsFromDB()]);
    final prodToUpdate = _items.indexWhere((prod) => prod.id == product.id);
    if (prodToUpdate >= 0) {
      await DatabaseService.update('Product', product.id, product.toMap());
      _items[prodToUpdate] = product;
      notifyListeners();
      return true;
    }
    return false;
  }

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite == 1).toList();
  }

  void addProduct(Product product) async {
    await DatabaseService.insert('product', product.toMap());
    _items.add(product);
    notifyListeners();
  }

  int get itemsCount => _items.length;
}
