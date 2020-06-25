import 'package:mobx/mobx.dart';

import '../receita/service/receita_load_service.dart';
import '../shared/helper/client_http_helper.dart';
import '../shared/helper/database_helper.dart';
import '../shared/helper/shared_preferences_helper.dart';
import 'model/usuario_form.dart';
import 'model/usuario_response.dart';

part 'usuario_controller.g.dart';

class UsuarioController = _UsuarioControllerBase with _$UsuarioController;

abstract class _UsuarioControllerBase with Store {
  final DatabaseHelper _databaseHelper;
  final ClientHttpHelper _clientHttpHelper;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  _UsuarioControllerBase(
    this._databaseHelper,
    this._clientHttpHelper,
    this._sharedPreferencesHelper,
  );

  Future<Null> signup(UsuarioForm usuarioForm) async {
    return _sign('/usuario', usuarioForm);
  }

  Future<Null> signin(UsuarioForm usuarioForm) async {
    return _sign('/usuario/auth', usuarioForm);
  }

  Future<Null> _sign(String path, UsuarioForm usuarioForm) async {
    var responseHttp = await _clientHttpHelper.post(
      path,
      usuarioForm.toJson(),
    );

    if (!responseHttp.isOk()) {
      var msg = responseHttp.message ?? 'Ops, encontramos um erro! [3]';
      throw FormatException(msg);
    }

    var data = responseHttp.data;
    var validData = !(data != null && data is Map);
    if (validData) {
      throw FormatException('Ops, encontramos um erro! [4]');
    }

    var usuarioResponse = UsuarioResponse.fromJson(data);
    await _sharedPreferencesHelper.setId(usuarioResponse.id);
    await _sharedPreferencesHelper.setNome(usuarioResponse.nome);
    await _sharedPreferencesHelper.setEmail(usuarioResponse.email);

    await configReceita();
  }

  void configReceita() async {
    var responseHttp = await _clientHttpHelper.get(
      "/receita",
    );

    if (responseHttp.isOk()) {
      var data = responseHttp.data;
      var validData = !(data != null && data is List);
      if (validData) {
        throw FormatException('Ops, encontramos um erro! [2]');
      }
      var service = ReceitaLoadService(_databaseHelper);
      await service.update(data);
    }
  }

  Future<String> forgot(UsuarioForm usuarioForm) async {
    var responseHttp = await _clientHttpHelper.post(
      '/usuario/forgot',
      usuarioForm.toJson(),
    );

    if (!responseHttp.isOk()) {
      var msg = responseHttp.message ?? 'Ops, encontramos um erro! [5]';
      throw FormatException(msg);
    }

    var data = responseHttp.data;
    var validData = !(data != null && data is bool);
    if (validData) {
      throw FormatException('Ops, encontramos um erro! [6]');
    }

    if (!data) {
      throw FormatException('Houve erro ao gerar nova senha!');
    }

    return responseHttp.message;
  }
}
