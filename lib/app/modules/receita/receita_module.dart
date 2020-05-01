import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/checklist/receita_checklist_module.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_module.dart';

class ReceitaModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => Container()),
        Router('/form', module: ReceitaFormModule()),
        Router('/checklist', module: ReceitaChecklistModule()),
      ];

  static Inject get to => Inject<ReceitaModule>.of();
}
