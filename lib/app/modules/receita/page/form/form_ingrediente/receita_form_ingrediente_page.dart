import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shareds/utils/validator/validator.dart';
import '../../../../../shareds/widgets/buttom_custom.dart';
import '../../../../../shareds/widgets/text_form_field_custom.dart';
import '../../../model/ingrediente.dart';
import '../receita_form_controller.dart';

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
          Text("Ingredientes"),
          SizedBox(height: 8.0),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextFormFieldCustom(
                    hintText: "10 ml, 100 gm, etc",
                    validators: [Validator.required()],
                    controller: _editingController,
                  ),
                ),
                SizedBox(width: 8.0),
                ButtomCustom(
                  heigth: 58,
                  width: 58,
                  onTap: onTapSaveIngrediente,
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
                List<Ingrediente> ingredientes = _formController.ingredientes;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: ingredientes.length,
                  itemBuilder: (_, index) =>
                      getItemIngrediente(ingredientes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemIngrediente(Ingrediente ingrediente) {
    var borderRadius = BorderRadius.circular(5.0);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: ListTile(
          title: Text(ingrediente.descricao),
          trailing: IconButton(
            onPressed: () => onPressedRemoveIngrediente(ingrediente),
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }

  void onTapSaveIngrediente() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      FocusScope.of(context).requestFocus(FocusNode());

      _formController.addIngrediente(Ingrediente(
        descricao: _editingController.text,
      ));

      setState(
        () => _editingController.text = "",
      );
    }
  }

  void onPressedRemoveIngrediente(Ingrediente ingrediente) {
    FocusScope.of(context).requestFocus(FocusNode());
    _formController.delIngrediente(ingrediente);
  }
}
