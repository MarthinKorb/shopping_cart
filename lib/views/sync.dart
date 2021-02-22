import 'package:flutter/material.dart';
import 'package:shop_/services/sync_service.dart';
import 'package:shop_/widgets/app_drawer.dart';

class RealSync extends StatefulWidget {
  @override
  _RealSyncState createState() => _RealSyncState();
}

class _RealSyncState extends State<RealSync> {
  Future<bool> isSuccess;

  @override
  Widget build(BuildContext context) {
    Future<bool> syncData(BuildContext context) async {
      return await SyncService(context: context).sincronizaDados();
    }

    syncData(context);

    return Scaffold(
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              'Sincronizando...',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
