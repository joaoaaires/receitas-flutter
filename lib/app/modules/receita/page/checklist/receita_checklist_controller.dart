import 'package:mobx/mobx.dart';

part 'receita_checklist_controller.g.dart';

class ReceitaChecklistController = _ReceitaChecklistControllerBase
    with _$ReceitaChecklistController;

abstract class _ReceitaChecklistControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
