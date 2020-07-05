import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/widget/buttom_custom.dart';
import '../../../shared/widget/dialog_custom.dart';
import '../../model/ingrediente.dart';
import '../../model/modo_preparo.dart';
import '../../model/receita.dart';
import '../list/receita_list_controller.dart';
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
    controller.load(receita);
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
                value: "excluir",
                child: Text("Excluir"),
              ),
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
              // var key = "I${ingrediente.id}";
              var key = "I$index";
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
              // var key = "M${modoPreparo.id}";
              var key = "M$index";
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
    } else if (value != null && value == "excluir") {
      onPressDeleteReceita();
    }
  }

  void onPressEditReceita() async {
    var receitaResponse = await Modular.to.pushNamed(
      "/receita/form",
      arguments: controller.receita,
    );
    controller.load(receitaResponse);
  }

  void onPressDeleteReceita() {
    DialogCustom.showProgress(context);
    controller.delete().then((response) {
      Navigator.pop(context);
      Modular.to.pop(true);
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.showAlertDialogUtil(
        context,
        "Atenção",
        error,
      );
    });
  }
}
