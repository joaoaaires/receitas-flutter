import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_controller.dart';
import 'package:receitas/app/shareds/widgets/buttom_custom.dart';
import 'package:receitas/app/shareds/widgets/text_form_field_custom.dart';

class ReceitaFormModoPreparoPage extends StatefulWidget {
  final String title;

  const ReceitaFormModoPreparoPage({Key key, this.title = "FormModoPreparo"})
      : super(key: key);

  @override
  _ReceitaFormModoPreparoPageState createState() =>
      _ReceitaFormModoPreparoPageState();
}

class _ReceitaFormModoPreparoPageState
    extends State<ReceitaFormModoPreparoPage> {
  ReceitaFormController _formController;
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _formController = Modular.get<ReceitaFormController>();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Modos de Preparos"),
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormFieldCustom(
                  hintText: "Levar ao forno por...",
                  controller: _editingController,
                ),
              ),
              SizedBox(width: 8.0),
              ButtomCustom(
                heigth: 58,
                width: 58,
                colorButtom: Colors.green,
                colorIcon: Colors.white,
                icon: Icons.add,
                onTap: () {
                  _formController.addModoPreparo(
                    _editingController.text,
                  );
                  _editingController.text = "";
                },
              ),
            ],
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                List<String> modosPreparo =
                    _formController.modosPreparo.reversed.toList();
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: modosPreparo.length,
                  itemBuilder: (_, index) {
                    return getItemModoPreparo(index, modosPreparo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemModoPreparo(int index, List<String> modosPreparo) {
    int size = modosPreparo.length;
    String modoPreparo = modosPreparo[index];
    BorderRadius borderRadius = BorderRadius.circular(5.0);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              "${size - index}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          Expanded(
            child: Material(
              elevation: 3.0,
              color: Colors.white,
              borderRadius: borderRadius,
              child: ListTile(
                title: Text(modoPreparo),
                trailing: IconButton(
                  onPressed: () => _formController.delModoPreparo(index),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text("${index + 1}"),
          Material(
            elevation: 3.0,
            color: Colors.white,
            borderRadius: borderRadius,
            child: ListTile(
              title: Text(modoPreparo),
              trailing: IconButton(
                onPressed: () => _formController.delModoPreparo(index),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
