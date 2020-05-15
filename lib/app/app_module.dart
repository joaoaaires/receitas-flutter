import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/receita/receita_module.dart';
import 'modules/splash/splash_module.dart';
import 'shareds/utils/database_helper.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DatabaseHelper()),
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: SplashModule()),
        //HOME
        Router('/home', module: HomeModule()),
        //PESSOA
        Router('/receita', module: ReceitaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
