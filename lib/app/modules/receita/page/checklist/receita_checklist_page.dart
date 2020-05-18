import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shareds/widgets/buttom_custom.dart';
import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
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
    controller.load();
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
          // getButtonFinalizarReceita(),
        ],
      ),
    );
  }

  Widget getTitleReceita() {
    return Observer(
      builder: (_) {
        var receita = controller.receita;
        return Text(
          receita != null ? receita.titulo : "Título",
          style: TextStyle(
            fontSize: 28.0,
          ),
        );
      },
    );
  }

  Widget getChecklistReceita() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getChecklistSubtitleReceita("Ingredientes"),
            getChecklistIngredientes(),
            getChecklistSubtitleReceita("Modo de Preparo"),
            getChecklistModosPreparo(),
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

  Widget getChecklistIngredientes() {
    return Observer(
      builder: (_) {
        List<Ingrediente> ingredientes = controller.ingredientes;

        if (ingredientes.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          children: List.generate(
            ingredientes.length,
            (index) {
              var ingrediente = ingredientes[index];
              var key = "I${ingrediente.id}";
              return Observer(
                builder: (_) {
                  return ListTile(
                    leading: Checkbox(
                      value: controller.value(key),
                      onChanged: (value) => controller.changeValue(key),
                    ),
                    title: Text(ingrediente.descricao),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget getChecklistModosPreparo() {
    return Observer(
      builder: (_) {
        List<ModoPreparo> modosPreparo = controller.modosPreparo;

        if (modosPreparo.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          children: List.generate(
            modosPreparo.length,
            (index) {
              var modoPreparo = modosPreparo[index];
              var key = "M${modoPreparo.id}";
              return ListTile(
                leading: Checkbox(
                  value: controller.value(key),
                  onChanged: (value) => controller.changeValue(key),
                ),
                title: Text(modoPreparo.descricao),
              );
            },
          ),
        );
      },
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

  void onPressEditReceita() async {
    var clickInButtonSave = await Modular.to.pushNamed(
      "/receita/form",
      arguments: controller.receita,
    );
    if (clickInButtonSave != null && clickInButtonSave) {
      controller.load();
    }
  }
}
