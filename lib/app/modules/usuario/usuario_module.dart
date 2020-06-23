import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/helper/client_http_helper.dart';
import '../shared/helper/shared_preferences_helper.dart';
import 'page/change_passwd/change_passwd_controller.dart';
import 'page/change_passwd/change_passwd_page.dart';
import 'page/forgot/forgot_page.dart';
import 'page/sign_in/sign_in_page.dart';
import 'page/sign_up/sign_up_page.dart';
import 'usuario_controller.dart';

class UsuarioModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChangePasswdController(
              i.get<ClientHttpHelper>(),
            )),
        Bind((i) => UsuarioController(
              i.get<ClientHttpHelper>(),
              i.get<SharedPreferencesHelper>(),
            )),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => Container()),
        Router('/signin', child: (_, args) => SignInPage()),
        Router('/signup', child: (_, args) => SignUpPage()),
        Router('/forgot', child: (_, args) => ForgotPage()),
        Router('/change', child: (_, args) => ChangePasswdPage()),
      ];

  static Inject get to => Inject<UsuarioModule>.of();
}
