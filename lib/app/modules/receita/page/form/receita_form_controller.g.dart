// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receita_form_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceitaFormController on _ReceitaFormControllerBase, Store {
  final _$ingredientesAtom =
      Atom(name: '_ReceitaFormControllerBase.ingredientes');

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
      Atom(name: '_ReceitaFormControllerBase.modosPreparo');

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

  final _$_ReceitaFormControllerBaseActionController =
      ActionController(name: '_ReceitaFormControllerBase');

  @override
  void addIngrediente(Ingrediente ingrediente) {
    final _$actionInfo =
        _$_ReceitaFormControllerBaseActionController.startAction();
    try {
      return super.addIngrediente(ingrediente);
    } finally {
      _$_ReceitaFormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delIngrediente(Ingrediente ingrediente) {
    final _$actionInfo =
        _$_ReceitaFormControllerBaseActionController.startAction();
    try {
      return super.delIngrediente(ingrediente);
    } finally {
      _$_ReceitaFormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addModoPreparo(ModoPreparo modoPreparo) {
    final _$actionInfo =
        _$_ReceitaFormControllerBaseActionController.startAction();
    try {
      return super.addModoPreparo(modoPreparo);
    } finally {
      _$_ReceitaFormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delModoPreparo(ModoPreparo modoPreparo) {
    final _$actionInfo =
        _$_ReceitaFormControllerBaseActionController.startAction();
    try {
      return super.delModoPreparo(modoPreparo);
    } finally {
      _$_ReceitaFormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'ingredientes: ${ingredientes.toString()},modosPreparo: ${modosPreparo.toString()}';
    return '{$string}';
  }
}
