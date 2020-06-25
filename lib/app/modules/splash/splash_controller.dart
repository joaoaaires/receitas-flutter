import '../receita/service/receita_load_service.dart';
import '../shared/helper/client_http_helper.dart';
import '../shared/helper/database_helper.dart';

class SplashController {
  final DatabaseHelper _halper;
  final ClientHttpHelper _client;

  SplashController(this._halper, this._client);

  Future<bool> loading() async {
    var database = await _halper.database;
    print("database ok! ${database != null}");

    var responseHttp = await _client.get(
      "/receita",
    );

    if (responseHttp.isOk()) {
      var data = responseHttp.data;
      var validData = !(data != null && data is List);
      if (validData) {
        throw FormatException('Ops, encontramos um erro! [2]');
      }

      var service = ReceitaLoadService(_halper);
      await service.update(data);
      return true;
    } else {
      return false;
    }
  }
}
