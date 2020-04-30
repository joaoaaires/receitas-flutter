import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/splash/splash_controller.dart';
import 'package:receitas/app/modules/splash/splash_page.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController(i.get<DatabaseHelper>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
