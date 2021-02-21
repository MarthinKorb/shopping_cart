import 'package:flutter/material.dart';
import 'package:shop_/utils/app_routes.dart';
import 'package:shop_/widgets/app_drawer.dart';

class SyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sincronização'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.sync,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'Sincronizar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.REAL_SYNC);
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
