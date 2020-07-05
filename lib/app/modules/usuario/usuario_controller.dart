import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

import '../shared/helper/shared_preferences_helper.dart';
import 'model/usuario_form.dart';

part 'usuario_controller.g.dart';

class UsuarioController = _UsuarioControllerBase with _$UsuarioController;

abstract class _UsuarioControllerBase with Store {
  final SharedPreferencesHelper _sharedPreferencesHelper;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _UsuarioControllerBase(
    this._sharedPreferencesHelper,
  );

  Future<Null> signup(UsuarioForm usuarioForm) async {
    return _sign('/usuario', usuarioForm);
  }

  Future<Null> signin(UsuarioForm usuarioForm) async {
    return _sign('/usuario/auth', usuarioForm);
  }

  Future<Null> _sign(String path, UsuarioForm usuarioForm) async {
    FirebaseUser firebaseUser;
    var isSignIn = path.contains('/usuario/auth');

    if (isSignIn) {
      var firebaseAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: usuarioForm.email,
        password: usuarioForm.senha,
      );
      firebaseUser = firebaseAuth.user;
    } else {
      var firebaseAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: usuarioForm.email,
        password: usuarioForm.senha,
      );
      firebaseUser = firebaseAuth.user;
    }

    if (firebaseUser == null) {
      if (isSignIn) {
        throw FormatException('Não foi possível realizar login.');
      } else {
        throw FormatException('Não foi possível realizar cadastrado.');
      }
    }

    await _sharedPreferencesHelper.setId(firebaseUser.uid);
    await _sharedPreferencesHelper.setEmail(firebaseUser.email);
  }

  Future<String> forgot(UsuarioForm usuarioForm) async {
    // var responseHttp = await _clientHttpHelper.post(
    //   '/usuario/forgot',
    //   usuarioForm.toJson(),
    // );

    // if (!responseHttp.isOk()) {
    //   var msg = responseHttp.message ?? 'Ops, encontramos um erro! [5]';
    //   throw FormatException(msg);
    // }

    // var data = responseHttp.data;
    // var validData = !(data != null && data is bool);
    // if (validData) {
    //   throw FormatException('Ops, encontramos um erro! [6]');
    // }

    // if (!data) {
    //   throw FormatException('Houve erro ao gerar nova senha!');
    // }

    // return responseHttp.message;
    return null;
  }
}
