import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/receita/receita_module.dart';
import 'modules/sign_in/sign_in_module.dart';
import 'modules/sign_up/sign_up_module.dart';
import 'modules/splash/splash_module.dart';
import 'shareds/http/client_http.dart';
import 'shareds/utils/database_helper.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => DatabaseHelper()),
        Bind((i) => ClientHttp()),
      ];

  @override
  List<Router> get routers => [
        //SPLASH
        Router('/', module: SplashModule()),
        //LOGIN
        Router('/signin', module: SignInModule()),
        //LOGIN
        Router('/signup', module: SignUpModule()),
        //HOME
        Router('/home', module: HomeModule()),
        //PESSOA
        Router('/receita', module: ReceitaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
