import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'receita_form_controller.dart';

class ReceitaFormPage extends StatefulWidget {
  final String title;
  const ReceitaFormPage({Key key, this.title = "ReceitaForm"})
      : super(key: key);

  @override
  _ReceitaFormPageState createState() => _ReceitaFormPageState();
}

class _ReceitaFormPageState
    extends ModularState<ReceitaFormPage, ReceitaFormController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
