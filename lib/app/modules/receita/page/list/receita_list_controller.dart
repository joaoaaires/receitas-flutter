import 'package:mobx/mobx.dart';

part 'receita_list_controller.g.dart';

class ReceitaListController = _ReceitaListControllerBase
    with _$ReceitaListController;

abstract class _ReceitaListControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
