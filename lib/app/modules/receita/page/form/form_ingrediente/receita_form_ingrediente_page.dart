import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/modules/receita/page/form/receita_form_controller.dart';
import 'package:receitas/app/shareds/widgets/buttom_custom.dart';
import 'package:receitas/app/shareds/widgets/text_form_field_custom.dart';

class ReceitaFormIngredientePage extends StatefulWidget {
  final String title;

  const ReceitaFormIngredientePage(
      {Key key, this.title = "ReceitaFormIngrediente"})
      : super(key: key);

  @override
  _ReceitaFormIngredientePageState createState() =>
      _ReceitaFormIngredientePageState();
}

class _ReceitaFormIngredientePageState
    extends State<ReceitaFormIngredientePage> {
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
          Text("Ingredientes"),
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormFieldCustom(
                  hintText: "10 ml, 100 gm, etc",
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
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _formController.addIngrediente(
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
                List<Ingrediente> ingredientes = _formController.ingredientes;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: ingredientes.length,
                  itemBuilder: (_, index) =>
                      getItemIngrediente(index, ingredientes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemIngrediente(int index, Ingrediente ingrediente) {
    BorderRadius borderRadius = BorderRadius.circular(5.0);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: ListTile(
          title: Text(ingrediente.descricao),
          trailing: IconButton(
            onPressed: () => _formController.delIngrediente(index),
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
