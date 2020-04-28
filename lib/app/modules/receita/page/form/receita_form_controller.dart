import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  @observable
  ObservableList<Ingrediente> ingredientes = <Ingrediente>[].asObservable();
  @observable
  ObservableList<ModoPreparo> modosPreparo = <ModoPreparo>[].asObservable();

  int currentyIndex = 0;
  Receita receita = new Receita();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void addIngrediente(String ingrediente) {
    ingredientes.add(Ingrediente(
      descricao: ingrediente,
    ));
  }

  @action
  void delIngrediente(int index) {
    ingredientes.removeAt(index);
  }

  @action
  void addModoPreparo(String modoPreparo) {
    modosPreparo.add(ModoPreparo(
      descricao: modoPreparo,
    ));
  }

  @action
  void delModoPreparo(int index) {
    modosPreparo.removeAt(index);
  }

  Future<Null> save() {
    if (!formKey.currentState.validate()) return null;

    formKey.currentState.save();


  }

}
