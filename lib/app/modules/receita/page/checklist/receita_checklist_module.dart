import 'package:flutter_modular/flutter_modular.dart';

import 'receita_checklist_controller.dart';
import 'receita_checklist_page.dart';

class ReceitaChecklistModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaChecklistController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => ReceitaChecklistPage()),
      ];

  static Inject get to => Inject<ReceitaChecklistModule>.of();
}
