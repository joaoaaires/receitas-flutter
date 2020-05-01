import 'package:receitas/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/list/receita_list_controller.dart';
import 'package:receitas/app/modules/receita/page/list/receita_list_page.dart';
import 'package:receitas/app/modules/receita/repository/receita_repository.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaListController(i.get<ReceitaRepository>())),
        Bind((i) => ReceitaRepository(i.get<DatabaseHelper>())),
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(
          Modular.initialRoute,
          child: (_, args) => ReceitaListPage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
