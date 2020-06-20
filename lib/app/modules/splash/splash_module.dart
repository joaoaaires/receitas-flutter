import 'package:flutter_modular/flutter_modular.dart';

import '../shared/helper/client_http_helper.dart';
import '../shared/helper/database_helper.dart';
import 'splash_controller.dart';
import 'splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController(
              i.get<DatabaseHelper>(),
              i.get<ClientHttpHelper>(),
            )),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
