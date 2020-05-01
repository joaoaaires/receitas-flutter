// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receita_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceitaListController on _ReceitaListControllerBase, Store {
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

  @override
  String toString() {
    final string = 'receitas: ${receitas.toString()}';
    return '{$string}';
  }
}
