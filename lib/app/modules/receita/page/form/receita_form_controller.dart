import 'package:mobx/mobx.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  @observable
  ObservableList<String> ingredientes = <String>[].asObservable();
  @observable
  ObservableList<String> modosPreparo = <String>[].asObservable();

  @action
  void addIngrediente(String ingrediente) {
    ingredientes.add(ingrediente);
  }

  @action
  void delIngrediente(int index) {
    ingredientes.removeAt(index);
  }

  @action
  void addModoPreparo(String modoPreparo) {
    modosPreparo.add(modoPreparo);
  }

  @action
  void delModoPreparo(int index) {
    modosPreparo.removeAt(index);
  }
}
