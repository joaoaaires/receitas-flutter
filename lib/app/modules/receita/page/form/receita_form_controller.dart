import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';
import 'package:receitas/app/modules/receita/repository/ingrediente_repository.dart';
import 'package:receitas/app/modules/receita/repository/modo_preparo_repository.dart';
import 'package:receitas/app/modules/receita/repository/receita_repository.dart';

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

  Receita receita = new Receita();
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
      List<Ingrediente> ingredientes =
      await ingredienteRepository.readByIdReceita(
        receita.id,
      );
      this.ingredientes = ingredientes.asObservable();
    }

    if (receita.id != null && receita.id != 0) {
      List<ModoPreparo> modosPreparo =
      await modoPreparoRepository.readByIdReceita(
        receita.id,
      );
      this.modosPreparo = modosPreparo.asObservable();
    }
  }

  Future<Null> save() async {
    if (!formKey.currentState.validate())
      throw "Alguns campos são obrigatórios.";

    if (ingredientes.isEmpty)
      throw "Por favor insira pelo menos um ingrediente.";

    if (modosPreparo.isEmpty)
      throw "Por favor insira pelo menos um modo de preparo.";

    formKey.currentState.save();

    if (receita.id != null && receita.id != 0) {
      receita.id = await receitaRepository.update(receita);
      print("receita editada! id: ${receita.id}");
    } else {
      receita.id = await receitaRepository.create(receita);
      print("receita cadastrada! id: ${receita.id}");
    }

    if (receita.id == 0) return;

    ingredientes.forEach((Ingrediente ingrediente) async {
      if (ingrediente.id == null || ingrediente.id == 0) {
        try {
          ingrediente.idreceita = receita.id;
          int id = await ingredienteRepository.create(
            ingrediente,
          );
          print("ingrediente cadastrada! id: $id");
        } catch (e) {
          print(e);
        }
      }
    });

    modosPreparo.forEach((ModoPreparo modoPreparo) async {
      if (modoPreparo.id == null || modoPreparo.id == 0) {
        try {
          modoPreparo.idreceita = receita.id;
          int id = await modoPreparoRepository.create(
            modoPreparo,
          );
          print("modo de preparo cadastrada! id: $id");
        } catch (e) {
          print(e);
        }
      }
    });

    ingredientesDel.forEach((Ingrediente ingrediente) async {
      if (ingrediente.id != null && ingrediente.id != 0) {
        try {
          await ingredienteRepository.delete(
            ingrediente.id,
          );
          print("ingrediente deletada! id: ${ingrediente.id}");
        } catch (e) {
          print(e);
        }
      }
    });

    modosPreparoDel.forEach((ModoPreparo modoPreparo) async {
      if (modoPreparo.id != null && modoPreparo.id != 0) {
        try {
          await modoPreparoRepository.delete(
            modoPreparo.id,
          );
          print("modo de preparo deletada! id: ${modoPreparo.id}");
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
