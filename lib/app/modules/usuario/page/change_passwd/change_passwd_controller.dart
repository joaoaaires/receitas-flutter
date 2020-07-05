import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'change_passwd_controller.g.dart';

class ChangePasswdController = _ChangePasswdControllerBase
    with _$ChangePasswdController;

abstract class _ChangePasswdControllerBase with Store {
  Future<String> change(String senhaAntiga, String senhaNova) async {
    // var responseHttp = await _clientHttpHelper.post(
    //   '/usuario/change',
    //   {
    //     "senhaAntiga": senhaAntiga,
    //     "senhaNova": senhaNova,
    //   },
    // );

    // if (!responseHttp.isOk()) {
    //   var msg = responseHttp.message ?? 'Ops, encontramos um erro! [7]';
    //   throw FormatException(msg);
    // }

    // var data = responseHttp.data;
    // var validData = !(data != null && data is bool);
    // if (validData) {
    //   throw FormatException('Ops, encontramos um erro! [8]');
    // }

    // if (!data) {
    //   throw FormatException('Houve erro ao cadastrar nova senha!');
    // }

    // return responseHttp.message;
    return null;
  }
}
