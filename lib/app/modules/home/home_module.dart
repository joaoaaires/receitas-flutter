import 'package:flutter_modular/flutter_modular.dart';

import '../../shareds/utils/database_helper.dart';
import '../receita/page/list/receita_list_controller.dart';
import '../receita/page/list/receita_list_page.dart';
import '../receita/repository/receita_repository.dart';
import 'home_controller.dart';

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
