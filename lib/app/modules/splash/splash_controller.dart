import '../shared/helper/client_http_helper.dart';
import '../shared/helper/database_helper.dart';

class SplashController {
  final DatabaseHelper _halper;
  final ClientHttpHelper _client;

  SplashController(this._halper, this._client);

  Future<Null> loading() async {
    await Future.delayed(Duration(seconds: 6));


    var database = await _halper.database;
    print("database ok! ${database != null}");

    await _client.get(
      "/receita",
    );
  }
}
