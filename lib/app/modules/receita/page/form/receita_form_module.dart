import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/form/form_ingrediente/receita_form_ingrediente_controller.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_controller.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_page.dart';

class ReceitaFormModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaFormIngredienteController()),
        Bind((i) => ReceitaFormController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ReceitaFormPage()),
      ];

  static Inject get to => Inject<ReceitaFormModule>.of();
}
