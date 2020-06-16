import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shareds/utils/database_helper.dart';
import '../../repository/ingrediente_repository.dart';
import '../../repository/modo_preparo_repository.dart';
import '../../repository/receita_repository.dart';
import 'receita_checklist_controller.dart';
import 'receita_checklist_page.dart';

class ReceitaChecklistModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaChecklistController(
              i.get<ReceitaRepository>(),
              i.get<IngredienteRepository>(),
              i.get<ModoPreparoRepository>(),
            )),
        Bind((i) => ModoPreparoRepository(i.get<DatabaseHelper>())),
        Bind((i) => IngredienteRepository(i.get<DatabaseHelper>())),
        Bind((i) => ReceitaRepository(i.get<DatabaseHelper>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => ReceitaChecklistPage()),
      ];

  static Inject get to => Inject<ReceitaChecklistModule>.of();
}
