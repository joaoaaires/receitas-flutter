import 'package:flutter_modular/flutter_modular.dart';

import 'sign_up_controller.dart';
import 'sign_up_page.dart';

class SignUpModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignUpController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignUpPage()),
      ];

  static Inject get to => Inject<SignUpModule>.of();
}
