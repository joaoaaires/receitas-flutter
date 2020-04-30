import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_controller.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_page.dart';
import 'package:receitas/app/modules/receita/repository/ingrediente_repository.dart';
import 'package:receitas/app/modules/receita/repository/modo_preparo_repository.dart';
import 'package:receitas/app/modules/receita/repository/receita_repository.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';

class ReceitaFormModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaFormController(
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
        Router(Modular.initialRoute, child: (_, args) => ReceitaFormPage()),
      ];

  static Inject get to => Inject<ReceitaFormModule>.of();
}
