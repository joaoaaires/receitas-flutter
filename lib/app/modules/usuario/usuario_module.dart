import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'page/forgot/forgot_page.dart';
import 'page/sign_in/sign_in_page.dart';
import 'page/sign_up/sign_up_page.dart';

class UsuarioModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => Container()),
        Router('/signin', child: (_, args) => SignInPage()),
        Router('/signup', child: (_, args) => SignUpPage()),
        Router('/forgot', child: (_, args) => ForgotPage()),
      ];

  static Inject get to => Inject<UsuarioModule>.of();
}
