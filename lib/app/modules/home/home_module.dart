import 'package:receitas/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/list/receita_list_controller.dart';
import 'package:receitas/app/modules/receita/page/list/receita_list_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaListController()),
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
