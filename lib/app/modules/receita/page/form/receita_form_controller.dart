import 'package:mobx/mobx.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  @observable
  ObservableList<String> ingredientes = <String>[].asObservable();

  @action
  void addIngrediente(String ingrediente) {
    ingredientes.add(ingrediente);
  }

  @action
  void delIngrediente(int index) {
    ingredientes.removeAt(index);
  }
}
