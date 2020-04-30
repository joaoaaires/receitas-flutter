import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';
import 'package:receitas/app/modules/receita/repository/ingrediente_repository.dart';
import 'package:receitas/app/modules/receita/repository/receita_repository.dart';

part 'receita_form_controller.g.dart';

class ReceitaFormController = _ReceitaFormControllerBase
    with _$ReceitaFormController;

abstract class _ReceitaFormControllerBase with Store {
  final ReceitaRepository receitaRepository;
  final IngredienteRepository ingredienteRepository;

  _ReceitaFormControllerBase(
    this.receitaRepository,
    this.ingredienteRepository,
  );

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

  Future<Null> save() async {
    try {
      if (!formKey.currentState.validate()) return null;

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

      Modular.to.pop();
    } catch (e) {
      print(e);
    }
  }
}
