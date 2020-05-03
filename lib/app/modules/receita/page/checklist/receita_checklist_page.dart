import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/model/receita.dart';
import 'receita_checklist_controller.dart';

class ReceitaChecklistPage extends StatefulWidget {
  final String title;

  const ReceitaChecklistPage({Key key, this.title = "Receita"})
      : super(key: key);

  @override
  _ReceitaChecklistPageState createState() => _ReceitaChecklistPageState();
}

class _ReceitaChecklistPageState
    extends ModularState<ReceitaChecklistPage, ReceitaChecklistController> {
  //use 'controller' variable to access controller

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Receita receita = ModalRoute.of(context).settings.arguments;
    controller.receita = receita;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: onSelectedAcaoReceita,
          itemBuilder: (_) {
            return [
              PopupMenuItem<String>(
                value: "editar",
                child: Text("Editar"),
              ),
            ];
          },
        ),
      ],
    );
  }

  void onSelectedAcaoReceita(String value) {
    if (value != null && value == "editar") {
      onPressEditReceita();
    }
  }

  void onPressEditReceita() {
    Modular.to.pushNamed(
      "/receita/form",
      arguments: controller.receita,
    );
  }

}
