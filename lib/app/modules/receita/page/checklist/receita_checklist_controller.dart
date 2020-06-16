import 'package:mobx/mobx.dart';

import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';
import '../../repository/ingrediente_repository.dart';
import '../../repository/modo_preparo_repository.dart';
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
  final IngredienteRepository ingredienteRepository;
  final ModoPreparoRepository modoPreparoRepository;

  _ReceitaChecklistControllerBase(
    this.receitaRepository,
    this.ingredienteRepository,
    this.modoPreparoRepository,
  );

  Future<void> load() async {
    if (receita != null && receita.id != null && receita.id != 0) {
      var db = await receitaRepository.readById(
        receita.id,
      );
      receita = db;
    }

    if (receita != null) {
      if (receita.id != null && receita.id != 0) {
        var ingredientes = await ingredienteRepository.readByIdReceita(
          receita.id,
        );
        this.ingredientes = ingredientes.asObservable();
      }

      if (receita.id != null && receita.id != 0) {
        var modosPreparo = await modoPreparoRepository.readByIdReceita(
          receita.id,
        );
        this.modosPreparo = modosPreparo.asObservable();
      }
    }
  }

  Future<void> delete() async {
    if (receita != null) {
      if (receita.id != null && receita.id != 0) {
        await modoPreparoRepository.deleteByIdReceita(receita.id);
        await ingredienteRepository.deleteByIdReceita(receita.id);
        await receitaRepository.delete(receita.id);
      }
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
