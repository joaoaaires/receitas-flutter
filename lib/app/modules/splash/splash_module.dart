import 'package:flutter_modular/flutter_modular.dart';

import '../../shareds/http/client_http.dart';
import '../../shareds/utils/database_helper.dart';
import 'splash_controller.dart';
import 'splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController(
              i.get<DatabaseHelper>(),
              i.get<ClientHttp>(),
            )),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
