import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReceitaModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => Container()),
  ];

  static Inject get to => Inject<ReceitaModule>.of();
}
