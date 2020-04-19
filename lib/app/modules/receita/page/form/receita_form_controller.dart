import 'package:mobx/mobx.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
