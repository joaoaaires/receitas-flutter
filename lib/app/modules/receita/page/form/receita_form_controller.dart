import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/helper/client_http_helper.dart';
import '../../../shared/model/response_http.dart';
import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';
import '../../repository/ingrediente_repository.dart';
import '../../repository/modo_preparo_repository.dart';
import '../../repository/receita_repository.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  final ClientHttpHelper _clientHttpHelper;
  final ReceitaRepository _receitaRepository;
  final IngredienteRepository _ingredienteRepository;
  final ModoPreparoRepository _modoPreparoRepository;

  _ReceitaFormControllerBase(
    this._clientHttpHelper,
    this._receitaRepository,
    this._ingredienteRepository,
    this._modoPreparoRepository,
  );

  int currentyIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Receita receita = Receita();
  List<Ingrediente> ingredientesDel = [];
  List<ModoPreparo> modosPreparoDel = [];
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
    ingredientesDel.add(ingrediente);
    ingredientes.remove(ingrediente);
  }

  @action
  void addModoPreparo(ModoPreparo modoPreparo) {
    modosPreparo.add(modoPreparo);
  }

  @action
  void delModoPreparo(ModoPreparo modoPreparo) {
    modosPreparoDel.add(modoPreparo);
    modosPreparo.remove(modoPreparo);
  }

  Future<Null> load() async {
    if (receita.id != null && receita.id != 0) {
      var ingredientes = await _ingredienteRepository.readByIdReceita(
        receita.id,
      );
      this.ingredientes = ingredientes.asObservable();
    }

    if (receita.id != null && receita.id != 0) {
      var modosPreparo = await _modoPreparoRepository.readByIdReceita(
        receita.id,
      );
      this.modosPreparo = modosPreparo.asObservable();
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

    //salvar receita
    await savePersistence();

    ResponseHttp responseHttp;
    var receitaJson = getReceitaJson();

    if (receita.idserver != null && receita.idserver != 0) {
      responseHttp = await _clientHttpHelper.put(
        '/receita',
        receitaJson,
      );
    } else {
      responseHttp = await _clientHttpHelper.post(
        '/receita',
        receitaJson,
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

    setReceitaJson(data);

    await savePersistence();
  }

  void savePersistence() async {
    //SAVE RECEITA
    int id;
    if (receita.id != null && receita.id != 0) {
      id = await _receitaRepository.update(receita);
    } else {
      id = await _receitaRepository.create(receita);
    }
    receita.id = id;

    //INSERIR INGREDIENTES
    for (var ingrediente in ingredientes) {
      int id;
      ingrediente.idreceita = receita.id;
      if (ingrediente.id != null && ingrediente.id != 0) {
        id = await _ingredienteRepository.update(ingrediente);
      } else {
        id = await _ingredienteRepository.create(ingrediente);
      }
      ingrediente.id = id;
    }

    //INSERIR MODO PREPARO
    for (var modoPreparo in modosPreparo) {
      int id;
      modoPreparo.idreceita = receita.id;
      if (modoPreparo.id != null && modoPreparo.id != 0) {
        id = await _modoPreparoRepository.update(modoPreparo);
      } else {
        id = await _modoPreparoRepository.create(modoPreparo);
      }
      modoPreparo.id = id;
    }

    //DELETAR INGREDIENTES
    for (var ingrediente in ingredientesDel) {
      if (ingrediente.id != null && ingrediente.id != 0) {
        await _ingredienteRepository.delete(ingrediente.id);
      }
    }

    //DELETAR INGREDIENTES
    for (var modoPreparo in modosPreparoDel) {
      if (modoPreparo.id != null && modoPreparo.id != 0) {
        await _modoPreparoRepository.delete(modoPreparo.id);
      }
    }
  }

  void setReceitaJson(Map<String, dynamic> json) {
    receita = Receita.fromMapHttp(json);
    var jsonIngredientes = json['ingredientes'] as List;
    var ingredientes = jsonIngredientes
        .map(
          (element) => Ingrediente.fromMapHttp(element),
        )
        .toList();
    this.ingredientes = ingredientes.asObservable();
    var jsonModoPreparo = json['modosPreparo'] as List;
    var modosPreparo = jsonModoPreparo
        .map(
          (element) => ModoPreparo.fromMapHttp(element),
        )
        .toList();
    this.modosPreparo = modosPreparo.asObservable();
  }

  Map<String, dynamic> getReceitaJson() {
    var json = receita.toJson();
    json['ingredientes'] = ingredientes
        .map(
          (element) => element.toJson(),
        )
        .toList();
    json['modosPreparo'] = modosPreparo
        .map(
          (element) => element.toJson(),
        )
        .toList();
    return json;
  }
}
