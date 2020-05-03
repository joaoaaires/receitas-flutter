import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';

part 'receita_checklist_controller.g.dart';

class ReceitaChecklistController = _ReceitaChecklistControllerBase
    with _$ReceitaChecklistController;

abstract class _ReceitaChecklistControllerBase with Store {

  Receita receita;

}
