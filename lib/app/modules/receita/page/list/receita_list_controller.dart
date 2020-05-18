import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../repository/receita_repository.dart';

part 'receita_list_controller.g.dart';

class ReceitaListController = _ReceitaListControllerBase
    with _$ReceitaListController;

abstract class _ReceitaListControllerBase with Store, Disposable {
  @observable
  ObservableFuture receitas;
  @observable
  bool showCampoPesquisa = false;

  final ReceitaRepository receitaRepository;

  Timer _debounce;
  TextEditingController textEditingController;

  _ReceitaListControllerBase(this.receitaRepository) {
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), update);
    });
    update();
  }

  void update() {
    // receitas = receitaRepository.read().asObservable();
    receitas = receitaRepository
        .readByTitulo(textEditingController.text)
        .asObservable();
  }

  @action
  void showPesquisa() {
    showCampoPesquisa = !showCampoPesquisa;
    if (!showCampoPesquisa) {
      textEditingController.text = "";
    }
  }

  @override
  void dispose() {
    textEditingController?.dispose();
  }
}
