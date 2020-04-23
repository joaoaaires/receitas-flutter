import 'package:flutter/material.dart';
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
                ),
              ),
              SizedBox(width: 8.0),
              ButtomCustom(),
            ],
          ),
          SizedBox(height: 8.0),
          FlatButton(
            onPressed: () {},
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
