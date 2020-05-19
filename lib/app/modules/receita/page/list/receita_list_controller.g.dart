// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receita_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceitaListController on _ReceitaListControllerBase, Store {
  final _$heightAtom = Atom(name: '_ReceitaListControllerBase.height');

  @override
  double get height {
    _$heightAtom.context.enforceReadPolicy(_$heightAtom);
    _$heightAtom.reportObserved();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.context.conditionallyRunInAction(() {
      super.height = value;
      _$heightAtom.reportChanged();
    }, _$heightAtom, name: '${_$heightAtom.name}_set');
  }

  final _$receitasAtom = Atom(name: '_ReceitaListControllerBase.receitas');

  @override
  ObservableFuture<dynamic> get receitas {
    _$receitasAtom.context.enforceReadPolicy(_$receitasAtom);
    _$receitasAtom.reportObserved();
    return super.receitas;
  }

  @override
  set receitas(ObservableFuture<dynamic> value) {
    _$receitasAtom.context.conditionallyRunInAction(() {
      super.receitas = value;
      _$receitasAtom.reportChanged();
    }, _$receitasAtom, name: '${_$receitasAtom.name}_set');
  }

  final _$showCampoPesquisaAtom =
      Atom(name: '_ReceitaListControllerBase.showCampoPesquisa');

  @override
  bool get showCampoPesquisa {
    _$showCampoPesquisaAtom.context.enforceReadPolicy(_$showCampoPesquisaAtom);
    _$showCampoPesquisaAtom.reportObserved();
    return super.showCampoPesquisa;
  }

  @override
  set showCampoPesquisa(bool value) {
    _$showCampoPesquisaAtom.context.conditionallyRunInAction(() {
      super.showCampoPesquisa = value;
      _$showCampoPesquisaAtom.reportChanged();
    }, _$showCampoPesquisaAtom, name: '${_$showCampoPesquisaAtom.name}_set');
  }

  final _$_ReceitaListControllerBaseActionController =
      ActionController(name: '_ReceitaListControllerBase');

  @override
  void showPesquisa() {
    final _$actionInfo =
        _$_ReceitaListControllerBaseActionController.startAction();
    try {
      return super.showPesquisa();
    } finally {
      _$_ReceitaListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showAdMob() {
    final _$actionInfo =
        _$_ReceitaListControllerBaseActionController.startAction();
    try {
      return super.showAdMob();
    } finally {
      _$_ReceitaListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideAdMob() {
    final _$actionInfo =
        _$_ReceitaListControllerBaseActionController.startAction();
    try {
      return super.hideAdMob();
    } finally {
      _$_ReceitaListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'height: ${height.toString()},receitas: ${receitas.toString()},showCampoPesquisa: ${showCampoPesquisa.toString()}';
    return '{$string}';
  }
}
