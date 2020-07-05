import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/model/response_http.dart';
import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';
import '../../repository/receita_repository.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  final ReceitaRepository _receitaRepository;

  _ReceitaFormControllerBase(
    this._receitaRepository,
  );

  bool init = true;
  int currentyIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Receita receita = Receita();
  @observable
  ObservableList<Ingrediente> ingredientes = <Ingrediente>[].asObservable();
  @observable
  ObservableList<ModoPreparo> modosPreparo = <ModoPreparo>[].asObservable();

  @action
  void addIngrediente(Ingrediente ingrediente) {
    ingredientes.add(ingrediente);
  }

  @action
  void delIngrediente(Ingrediente ingrediente) {
    ingredientes.remove(ingrediente);
  }

  @action
  void addModoPreparo(ModoPreparo modoPreparo) {
    modosPreparo.add(modoPreparo);
  }

  @action
  void delModoPreparo(ModoPreparo modoPreparo) {
    modosPreparo.remove(modoPreparo);
  }

  Future<Null> load(Receita receita) async {
    if (init) {
      if (receita != null) {
        ingredientes = receita.ingredientes.asObservable();
      }
      if (receita != null) {
        modosPreparo = receita.modosPreparo.asObservable();
      }
      if (receita != null) this.receita = receita;
      init = false;
    }
  }

  Future<Null> save() async {
    if (!formKey.currentState.validate()) {
      throw "Alguns campos são obrigatórios.";
    }

    if (ingredientes.isEmpty) {
      throw "Por favor insira pelo menos um ingrediente.";
    }

    if (modosPreparo.isEmpty) {
      throw "Por favor insira pelo menos um modo de preparo.";
    }

    formKey.currentState.save();
    receita.ingredientes = ingredientes;
    receita.modosPreparo = modosPreparo;

    var receitaJson = receita.toJson();
    print('>>>>>>>>>>>>>>>>>> $receitaJson');
    if (receita.reference != null) {
      _receitaRepository.update(receita.reference, receitaJson);
    } else {
      _receitaRepository.create(receitaJson);
    }
  }
}
