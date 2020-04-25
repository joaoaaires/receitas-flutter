import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/form/form_ingrediente/receita_form_ingrediente_page.dart';
import 'package:receitas/app/modules/receita/page/form/form_modo_preparo/receita_form_modo_preparo_page.dart';
import 'package:receitas/app/modules/receita/widget/receita_dots.dart';
import 'package:receitas/app/shareds/utils/validator/validator.dart';
import 'package:receitas/app/shareds/widgets/text_form_field_custom.dart';
import 'receita_form_controller.dart';

class ReceitaFormPage extends StatefulWidget {
  final String title;

  const ReceitaFormPage({Key key, this.title = "Nova Receita"})
      : super(key: key);

  @override
  _ReceitaFormPageState createState() => _ReceitaFormPageState();
}

class _ReceitaFormPageState
    extends ModularState<ReceitaFormPage, ReceitaFormController> {
  ReceitaFormController _formController;

  @override
  void initState() {
    super.initState();
    this._formController = Modular.get<ReceitaFormController>();
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
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.save),
        ),
      ],
    );
  }

  Widget getBody() {
    const double padding = 16.0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Form(
            key: _formController.formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: TextFormFieldCustom(
                labelText: "Título",
                initialValue: _formController.receita.titulo,
                onSaved: (value) => _formController.receita.titulo = value,
                validators: [Validator.required()],
              ),
            ),
          ),
          ReceitaDots(
            currentyIndex: _formController.currentyIndex,
            sizePage: 2,
          ),
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChangedPageView,
              children: <Widget>[
                ReceitaFormIngredientePage(),
                ReceitaFormModoPreparoPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onPageChangedPageView(index) {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _formController.currentyIndex = index;
    });
  }
}
