import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/helper/shared_preferences_helper.dart';
import '../../repository/receita_repository.dart';
import 'receita_form_controller.dart';
import 'receita_form_page.dart';

class ReceitaFormModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReceitaFormController(i.get<ReceitaRepository>())),
        Bind((i) => ReceitaRepository(i.get<SharedPreferencesHelper>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ReceitaFormPage()),
      ];

  static Inject get to => Inject<ReceitaFormModule>.of();
}
