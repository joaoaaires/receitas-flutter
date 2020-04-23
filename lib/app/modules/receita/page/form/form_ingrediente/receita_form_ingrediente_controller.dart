import 'package:mobx/mobx.dart';

part 'receita_form_ingrediente_controller.g.dart';

class ReceitaFormIngredienteController = _ReceitaFormIngredienteControllerBase
    with _$ReceitaFormIngredienteController;

abstract class _ReceitaFormIngredienteControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
