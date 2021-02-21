import 'package:flutter/material.dart';
import 'package:shop_/services/sync_service.dart';
import 'package:shop_/widgets/app_drawer.dart';

class RealSync extends StatefulWidget {
  @override
  _RealSyncState createState() => _RealSyncState();
}

class _RealSyncState extends State<RealSync> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    syncData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SYNC'),
      ),
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

  void syncData(BuildContext context) async {
    bool isSuccess = await SyncService(context: context).sincronizaDados();
    if (isSuccess) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Sucesso')),
      );
    }
  }
}
