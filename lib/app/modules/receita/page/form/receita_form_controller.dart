import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/helper/client_http_helper.dart';
import '../../../shared/model/response_http.dart';
import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  final ClientHttpHelper _clientHttpHelper;

  _ReceitaFormControllerBase(this._clientHttpHelper);

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

  Future<Null> load() async {
    // if (receita.id != null && receita.id != 0) {
    //   var ingredientes = await ingredienteRepository.readByIdReceita(
    //     receita.id,
    //   );
    //   this.ingredientes = ingredientes.asObservable();
    // }

    // if (receita.id != null && receita.id != 0) {
    //   var modosPreparo = await modoPreparoRepository.readByIdReceita(
    //     receita.id,
    //   );
    //   this.modosPreparo = modosPreparo.asObservable();
    // }
  }

  Future<Null> save() async {
    if (!formKey.currentState.validate()) {
      throw "Alguns campos são obrigatórios.";
    }

    if (this.ingredientes.isEmpty) {
      throw "Por favor insira pelo menos um ingrediente.";
    }

    if (this.modosPreparo.isEmpty) {
      throw "Por favor insira pelo menos um modo de preparo.";
    }

    formKey.currentState.save();

    ResponseHttp responseHttp;
    var json = receita.toJson();
    json['ingredientes'] = this
        .ingredientes
        .map(
          (element) => element.toJson(),
        )
        .toList();
    json['modosPreparo'] = this
        .modosPreparo
        .map(
          (element) => element.toJson(),
        )
        .toList();

    if (receita.id != null && receita.id != 0) {
      responseHttp = await _clientHttpHelper.put(
        '/receita',
        json,
      );
    } else {
      responseHttp = await _clientHttpHelper.post(
        '/receita',
        json,
      );
    }

    if (!responseHttp.isOk()) {
      var msg = responseHttp.message ?? 'Ops, encontramos um erro! [1]';
      throw msg;
    }

    var data = responseHttp.data;
    var validData = !(data != null && data is Map);
    if (validData) {
      throw FormatException('Ops, encontramos um erro! [2]');
    }

    receita = Receita.fromMap(data);
    var ingredientes = data['ingredientes']
        .map((element) => Ingrediente.fromMap(element))
        .toList();
    this.ingredientes = ingredientes.asObservable();
    var modosPreparo = data['modosPreparo']
        .map((element) => ModoPreparo.fromMap(element))
        .toList();
    this.modosPreparo = modosPreparo.asObservable();
  }
}
