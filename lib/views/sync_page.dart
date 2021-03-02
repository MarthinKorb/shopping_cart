import 'package:flutter/material.dart';
import 'package:shop_/services/sync_service.dart';
import 'package:shop_/widgets/app_drawer.dart';

class SyncPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            Image.asset('assets/images/sync.png', height: 160),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: FlatButton(
                height: 42,
                child: Text(
                  'Sincronizar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  // await Navigator.of(context).pushNamed(AppRoutes.REAL_SYNC);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        body: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Sincronizando...',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  Future.delayed(const Duration(seconds: 3), () async {
                    final syncSuccess =
                        await SyncService(context: context).sincronizaDados();
                    var message = 'Sincronização concluída com sucesso.';
                    if (!syncSuccess) {
                      message = 'Erro ao fazer a sincronização';
                    }
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(
                          message,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                    Navigator.of(context).pop();
                  });
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
