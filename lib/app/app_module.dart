import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/receita/receita_module.dart';
import 'modules/shared/helper/client_http_helper.dart';
import 'modules/shared/helper/database_helper.dart';
import 'modules/shared/helper/shared_preferences_helper.dart';
import 'modules/splash/splash_module.dart';
import 'modules/usuario/usuario_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => ClientHttpHelper(i.get<SharedPreferencesHelper>())),
        Bind((i) => SharedPreferencesHelper()),
        Bind((i) => DatabaseHelper()),
      ];

  @override
  List<Router> get routers => [
        //USUARIO
        Router(Modular.initialRoute, module: SplashModule()),
        //USUARIO
        Router('/usuario', module: UsuarioModule()),
        //HOME
        Router('/home', module: HomeModule()),
        //PESSOA
        Router('/receita', module: ReceitaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
