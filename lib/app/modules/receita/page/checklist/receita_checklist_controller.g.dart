// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receita_checklist_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceitaChecklistController on _ReceitaChecklistControllerBase, Store {
  final _$receitaAtom = Atom(name: '_ReceitaChecklistControllerBase.receita');

  @override
  Receita get receita {
    _$receitaAtom.context.enforceReadPolicy(_$receitaAtom);
    _$receitaAtom.reportObserved();
    return super.receita;
  }

  @override
  set receita(Receita value) {
    _$receitaAtom.context.conditionallyRunInAction(() {
      super.receita = value;
      _$receitaAtom.reportChanged();
    }, _$receitaAtom, name: '${_$receitaAtom.name}_set');
  }

  final _$ingredientesAtom =
      Atom(name: '_ReceitaChecklistControllerBase.ingredientes');

  @override
  ObservableList<Ingrediente> get ingredientes {
    _$ingredientesAtom.context.enforceReadPolicy(_$ingredientesAtom);
    _$ingredientesAtom.reportObserved();
    return super.ingredientes;
  }

  @override
  set ingredientes(ObservableList<Ingrediente> value) {
    _$ingredientesAtom.context.conditionallyRunInAction(() {
      super.ingredientes = value;
      _$ingredientesAtom.reportChanged();
    }, _$ingredientesAtom, name: '${_$ingredientesAtom.name}_set');
  }

  final _$modosPreparoAtom =
      Atom(name: '_ReceitaChecklistControllerBase.modosPreparo');

  @override
  ObservableList<ModoPreparo> get modosPreparo {
    _$modosPreparoAtom.context.enforceReadPolicy(_$modosPreparoAtom);
    _$modosPreparoAtom.reportObserved();
    return super.modosPreparo;
  }

  @override
  set modosPreparo(ObservableList<ModoPreparo> value) {
    _$modosPreparoAtom.context.conditionallyRunInAction(() {
      super.modosPreparo = value;
      _$modosPreparoAtom.reportChanged();
    }, _$modosPreparoAtom, name: '${_$modosPreparoAtom.name}_set');
  }

  final _$checklistItensAtom =
      Atom(name: '_ReceitaChecklistControllerBase.checklistItens');

  @override
  ObservableList<ReceitaChecklistItemController> get checklistItens {
    _$checklistItensAtom.context.enforceReadPolicy(_$checklistItensAtom);
    _$checklistItensAtom.reportObserved();
    return super.checklistItens;
  }

  @override
  set checklistItens(ObservableList<ReceitaChecklistItemController> value) {
    _$checklistItensAtom.context.conditionallyRunInAction(() {
      super.checklistItens = value;
      _$checklistItensAtom.reportChanged();
    }, _$checklistItensAtom, name: '${_$checklistItensAtom.name}_set');
  }

  final _$_ReceitaChecklistControllerBaseActionController =
      ActionController(name: '_ReceitaChecklistControllerBase');

  @override
  void changeValue(String key) {
    final _$actionInfo =
        _$_ReceitaChecklistControllerBaseActionController.startAction();
    try {
      return super.changeValue(key);
    } finally {
      _$_ReceitaChecklistControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'receita: ${receita.toString()},ingredientes: ${ingredientes.toString()},modosPreparo: ${modosPreparo.toString()},checklistItens: ${checklistItens.toString()}';
    return '{$string}';
  }
}
