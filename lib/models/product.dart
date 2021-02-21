import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final dynamic id;
  final String title;
  final String description;
  final dynamic price;
  final String image;
  final String category;
  int isFavorite = 0;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.category,
    @required this.isFavorite,
  });

  void toggleFavorite() {
    if (isFavorite == 0) {
      isFavorite = 1;
    } else {
      isFavorite = 0;
    }
    notifyListeners();
  }

  Product copyWith({
    dynamic id,
    String title,
    String description,
    dynamic price,
    String image,
    String category,
    bool isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      image: map['image'],
      category: map['category'],
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, image: $image, category: $category, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.id == id &&
        o.title == title &&
        o.description == description &&
        o.price == price &&
        o.image == image &&
        o.category == category &&
        o.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode ^
        category.hashCode ^
        isFavorite.hashCode;
  }
}
