import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';
import 'package:receitas/app/modules/receita/repository/receita_repository.dart';

part 'receita_list_controller.g.dart';

class ReceitaListController = _ReceitaListControllerBase
    with _$ReceitaListController;

abstract class _ReceitaListControllerBase with Store {
  @observable
  ObservableFuture receitas;

  final ReceitaRepository receitaRepository;

  _ReceitaListControllerBase(this.receitaRepository) {
    update();
  }

  void update() {
    receitas = receitaRepository.read().asObservable();
//    receitaRepository.read().then(onValue);
  }
}
