import 'package:mobx/mobx.dart';

part 'receita_checklist_item_controller.g.dart';

class ReceitaChecklistItemController = _ReceitaChecklistItemControllerBase
    with _$ReceitaChecklistItemController;

abstract class _ReceitaChecklistItemControllerBase with Store {
  @observable
  bool value = false;
  final String checklistKey;

  _ReceitaChecklistItemControllerBase(this.checklistKey);

}
