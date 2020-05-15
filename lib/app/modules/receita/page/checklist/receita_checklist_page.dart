import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shareds/widgets/buttom_custom.dart';
import '../../model/receita.dart';
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
      body: getBody(),
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

  Widget getBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getTitleReceita(),
          getChecklistReceita(),
          getButtonFinalizarReceita(),
        ],
      ),
    );
  }

  Widget getTitleReceita() {
    return Text(
      controller.receita.titulo,
      style: TextStyle(
        fontSize: 28.0,
      ),
    );
  }

  Widget getChecklistReceita() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getChecklistSubtitleReceita("Ingredientes"),
            getChecklistSubtitleReceita("Modo de Preparo"),
          ],
        ),
      ),
      // child: ListView(
      //   physics: BouncingScrollPhysics(),
      //   children: <Widget>[

      //   ],
      // ),
    );
  }

  Widget getChecklistSubtitleReceita(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget getButtonFinalizarReceita() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ButtomCustom(
        text: "Finalizar Receita",
        colorText: Colors.white,
        colorButtom: Colors.red,
        onTap: () {},
      ),
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
