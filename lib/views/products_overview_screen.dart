import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/providers/cart_provider.dart';
import 'package:shop_/shared/utils/app_routes.dart';
import 'package:shop_/widgets/app_drawer.dart';
import 'package:shop_/widgets/badge.dart';
import 'package:shop_/widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _showCompactGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showFavoritesOnly ? Text('Meus Favoritos') : Text(''),
        actions: [
          IconButton(
            icon: _showCompactGrid
                ? Icon(Icons.filter_list_outlined)
                : Icon(Icons.filter_list_alt),
            onPressed: () {
              setState(() {
                _showCompactGrid = !_showCompactGrid;
              });
            },
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoritesOnly = true;
                }
                if (selectedValue == FilterOptions.All) {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child,
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showOnlyFavorite: _showFavoritesOnly,
        showCompactGrid: _showCompactGrid,
      ),
      drawer: AppDrawer(),
    );
  }
}
