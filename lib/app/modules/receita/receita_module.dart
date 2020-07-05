import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/helper/shared_preferences_helper.dart';
import '../usuario/usuario_controller.dart';
import 'page/checklist/receita_checklist_module.dart';
import 'page/form/receita_form_module.dart';

class ReceitaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => UsuarioController(i.get<SharedPreferencesHelper>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => Container()),
        Router('/form', module: ReceitaFormModule()),
        Router('/checklist', module: ReceitaChecklistModule()),
      ];

  static Inject get to => Inject<ReceitaModule>.of();
}
