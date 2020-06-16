import 'package:receitas/app/shareds/http/client_http.dart';

import '../../shareds/utils/database_helper.dart';

class SplashController {
  final ClientHttp _client;
  final DatabaseHelper _halper;

  SplashController(this._halper, this._client);

  Future<Null> loading() async {
    await Future.delayed(Duration(seconds: 6));
    var database = await _halper.database;
    print("database ok! ${database != null}");

    await _client.post(
      "/usuario/auth",
      {},
    );
  }
}
