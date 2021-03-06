import 'package:flutter/material.dart';
import 'package:shop_/shared/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('Bem vindo!')),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.MY_ORDERS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manutenção de Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.sync_outlined),
            title: Text('Sincronizar'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.SYNC_PAGE);
            },
          ),
        ],
      ),
    );
  }
}
