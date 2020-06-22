import 'package:mobx/mobx.dart';

part 'change_passwd_controller.g.dart';

class ChangePasswdController = _ChangePasswdControllerBase
    with _$ChangePasswdController;

abstract class _ChangePasswdControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
