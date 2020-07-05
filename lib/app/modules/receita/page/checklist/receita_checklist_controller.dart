import 'package:mobx/mobx.dart';

import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';
import '../../repository/receita_repository.dart';
import '../../store/receita_checklist_item_controller.dart';

part 'receita_checklist_controller.g.dart';

class ReceitaChecklistController = _ReceitaChecklistControllerBase
    with _$ReceitaChecklistController;

abstract class _ReceitaChecklistControllerBase with Store {
  @observable
  Receita receita;
  @observable
  ObservableList<Ingrediente> ingredientes = <Ingrediente>[].asObservable();
  @observable
  ObservableList<ModoPreparo> modosPreparo = <ModoPreparo>[].asObservable();
  @observable
  ObservableList<ReceitaChecklistItemController> checklistItens =
      <ReceitaChecklistItemController>[].asObservable();

  final ReceitaRepository receitaRepository;

  _ReceitaChecklistControllerBase(
    this.receitaRepository,
  );

  Future<void> load(Receita receita) async {
    if (receita != null) {
      ingredientes = receita.ingredientes.asObservable();
    }
    if (receita != null) {
      modosPreparo = receita.modosPreparo.asObservable();
    }
    if (receita != null) this.receita = receita;
  }

  Future<void> delete() async {
    if (receita.reference != null) {
      await receitaRepository.delete(receita.reference);
    }
  }

  bool value(String key) {
    var receitaChecklistItemController = checklistItens.singleWhere(
      (element) => element.checklistKey == key,
      orElse: () => null,
    );
    return receitaChecklistItemController != null
        ? receitaChecklistItemController.value
        : false;
  }

  @action
  void changeValue(String key) {
    var receitaChecklistItemController = checklistItens.singleWhere(
      (element) => element.checklistKey == key,
      orElse: () => null,
    );
    if (receitaChecklistItemController == null) {
      checklistItens.add(
        receitaChecklistItemController = ReceitaChecklistItemController(
          key,
        ),
      );
      receitaChecklistItemController.value = true;
    } else {
      receitaChecklistItemController.value =
          !receitaChecklistItemController.value;
    }
  }
}
