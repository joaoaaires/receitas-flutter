import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';

import '../../repository/receita_repository.dart';

part 'receita_list_controller.g.dart';

class ReceitaListController = _ReceitaListControllerBase
    with _$ReceitaListController;

abstract class _ReceitaListControllerBase extends Disposable with Store {
  @observable
  double height = 0;
  @observable
  ObservableStream<List<Receita>> receitas;
  @observable
  bool showCampoPesquisa = false;

  final ReceitaRepository receitaRepository;
  final bool _kReleaseMode = const bool.fromEnvironment("dart.vm.product");

  Timer _debounce;
  String adUnitID;
  StreamSubscription subscription;
  NativeAdmobController nativeAdmobController;
  TextEditingController textEditingController;

  _ReceitaListControllerBase(this.receitaRepository) {
    nativeAdmobController = NativeAdmobController();
    subscription = nativeAdmobController.stateChanged.listen(onStateChanged);
    if (_kReleaseMode) {
      adUnitID = "ca-app-pub-3698978879549955/3613339277";
    } else {
      adUnitID = "ca-app-pub-3940256099942544/2247696110";
    }

    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), update);
    });

    update();
  }

  void update() async {
    receitas = (await receitaRepository.read()).asObservable();
  }

  void onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        hideAdMob();
        break;

      case AdLoadState.loadCompleted:
        showAdMob();
        break;

      default:
        break;
    }
  }

  @action
  void showPesquisa() {
    showCampoPesquisa = !showCampoPesquisa;
    if (!showCampoPesquisa) {
      textEditingController.text = "";
    }
  }

  @action
  void showAdMob() {
    height = 90;
  }

  @action
  void hideAdMob() {
    height = 0;
  }

  @override
  void dispose() {
    subscription?.cancel();
    nativeAdmobController?.dispose();
    textEditingController?.dispose();
  }
}
