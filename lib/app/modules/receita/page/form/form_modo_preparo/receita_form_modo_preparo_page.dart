import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_controller.dart';
import 'package:receitas/app/shareds/utils/validator/validator.dart';
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
  GlobalKey<FormState> _formKey;
  ReceitaFormController _formController;
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _formController = Modular.get<ReceitaFormController>();
    _editingController = TextEditingController();
    _formKey = GlobalKey();
  }

  @override
  void dispose() {
    _editingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Modos de Preparos"),
          SizedBox(height: 8.0),
          Form(
            key: _formKey,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormFieldCustom(
                    hintText: "Levar ao forno por...",
                    validators: [Validator.required()],
                    controller: _editingController,
                  ),
                ),
                SizedBox(width: 8.0),
                ButtomCustom(
                  heigth: 58,
                  width: 58,
                  onTap: onTapSaveModoPreparo,
                  colorButtom: Colors.green,
                  colorIcon: Colors.white,
                  icon: Icons.add,
                ),
              ],
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                List<ModoPreparo> modosPreparo =
                    _formController.modosPreparo.reversed.toList();
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: modosPreparo.length,
                  itemBuilder: (_, index) {
                    return getItemModoPreparo(
                      index,
                      modosPreparo[index],
                      modosPreparo.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemModoPreparo(int index, ModoPreparo modoPreparo, int size) {
    BorderRadius borderRadius = BorderRadius.circular(5.0);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              "${size - index}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          title: Text(modoPreparo.descricao),
          trailing: IconButton(
//            onPressed: () => _formController.delModoPreparo(index),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  void onTapSaveModoPreparo() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      FocusScope.of(context).requestFocus(new FocusNode());

      _formController.addModoPreparo(ModoPreparo(
        descricao: _editingController.text,
      ));

      setState(
        () => _editingController.text = "",
      );
    }
  }
}
