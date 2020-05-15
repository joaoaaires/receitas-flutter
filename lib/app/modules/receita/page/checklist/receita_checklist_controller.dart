import 'package:mobx/mobx.dart';

import '../../model/receita.dart';

part 'receita_checklist_controller.g.dart';

class ReceitaChecklistController = _ReceitaChecklistControllerBase
    with _$ReceitaChecklistController;

abstract class _ReceitaChecklistControllerBase with Store {

  Receita receita;

}
