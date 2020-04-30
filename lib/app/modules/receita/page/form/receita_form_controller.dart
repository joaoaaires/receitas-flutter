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

  Future<Null> save() async {
    if (!formKey.currentState.validate())
      throw "Alguns campos são obrigatórios.";

    if (ingredientes.isEmpty)
      throw "Por favor insira pelo menos um ingrediente.";

    if (modosPreparo.isEmpty)
      throw "Por favor insira pelo menos um modo de preparo.";

    formKey.currentState.save();

    Receita receitaDb = await receitaRepository.create(receita);
    print("receita cadastrada! id: ${receitaDb.id}");

    ingredientes.forEach((Ingrediente ingrediente) async {
      if (ingrediente.id == null || ingrediente.id == 0) {
        try {
          ingrediente.idreceita = receitaDb.id;
          Ingrediente ingredienteDb = await ingredienteRepository.create(
            ingrediente,
          );
          print("ingrediente cadastrada! id: ${ingredienteDb.id}");
        } catch (e) {
          print(e);
        }
      }
    });

    modosPreparo.forEach((ModoPreparo modoPreparo) async {
      if (modoPreparo.id == null || modoPreparo.id == 0) {
        try {
          modoPreparo.idreceita = receitaDb.id;
          ModoPreparo modoPreparoDb = await modoPreparoRepository.create(
            modoPreparo,
          );
          print("modo de preparo cadastrada! id: ${modoPreparoDb.id}");
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
