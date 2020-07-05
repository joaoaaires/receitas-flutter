import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import '../shared/helper/firebase_auth_error_helper.dart';
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
    String errorCode;
    FirebaseUser firebaseUser;
    var isSignIn = path.contains('/usuario/auth');

    try {
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
    } on PlatformException catch (e) {
      errorCode = e.code;
    }

    if (errorCode != null) {
      var msg = FirebaseAuthErrorHelper.getError(errorCode);
      throw FormatException(msg);
    }

    await _sharedPreferencesHelper.setId(firebaseUser.uid);
    await _sharedPreferencesHelper.setEmail(firebaseUser.email);
  }

  Future<String> forgot(UsuarioForm usuarioForm) async {
    await _firebaseAuth.sendPasswordResetEmail(email: usuarioForm.email);
    return "E-mail enviado!";
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
