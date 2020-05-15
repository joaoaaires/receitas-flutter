import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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
  final ReceitaRepository receitaRepository;
  final IngredienteRepository ingredienteRepository;
  final ModoPreparoRepository modoPreparoRepository;

  _ReceitaFormControllerBase(
    this.receitaRepository,
    this.ingredienteRepository,
    this.modoPreparoRepository,
  );

  Receita receita = Receita();
  List<Ingrediente> ingredientesDel = <Ingrediente>[];
  List<ModoPreparo> modosPreparoDel = <ModoPreparo>[];

  int currentyIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    //carregar ingredientes e modo de preparo
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

    if (receita.id != null && receita.id != 0) {
      receita.id = await receitaRepository.update(receita);
      print("receita editada! id: ${receita.id}");
    } else {
      receita.id = await receitaRepository.create(receita);
      print("receita cadastrada! id: ${receita.id}");
    }

    if (receita.id == 0) return;

    for (var ingrediente in ingredientes) {
      if (ingrediente.id == null || ingrediente.id == 0) {
        try {
          ingrediente.idreceita = receita.id;
          var id = await ingredienteRepository.create(
            ingrediente,
          );
          print("ingrediente cadastrada! id: $id");
        } on Exception catch (e) {
          print(e);
        }
      }
    }

    for (var modoPreparo in modosPreparo) {
      if (modoPreparo.id == null || modoPreparo.id == 0) {
        try {
          modoPreparo.idreceita = receita.id;
          var id = await modoPreparoRepository.create(
            modoPreparo,
          );
          print("modo de preparo cadastrada! id: $id");
        } on Exception catch (e) {
          print(e);
        }
      }
    }

    for (var ingrediente in ingredientesDel) {
      if (ingrediente.id != null && ingrediente.id != 0) {
        try {
          await ingredienteRepository.delete(
            ingrediente.id,
          );
          print("ingrediente deletada! id: ${ingrediente.id}");
        } on Exception catch (e) {
          print(e);
        }
      }
    }

    for (var modoPreparo in modosPreparoDel) {
      if (modoPreparo.id != null && modoPreparo.id != 0) {
        try {
          await modoPreparoRepository.delete(
            modoPreparo.id,
          );
          print("modo de preparo deletada! id: ${modoPreparo.id}");
        } on Exception catch (e) {
          print(e);
        }
      }
    }
  }
}
