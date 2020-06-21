import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/util/validator/validator.dart';
import '../../../shared/widget/dialog_custom.dart';
import '../../../shared/widget/text_form_field_custom.dart';
import '../../model/receita.dart';
import '../../widget/receita_dots.dart';
import 'form_ingrediente/receita_form_ingrediente_page.dart';
import 'form_modo_preparo/receita_form_modo_preparo_page.dart';
import 'receita_form_controller.dart';

class ReceitaFormPage extends StatefulWidget {
  final String title;

  const ReceitaFormPage({Key key, this.title = "Receita"}) : super(key: key);

  @override
  _ReceitaFormPageState createState() => _ReceitaFormPageState();
}

class _ReceitaFormPageState
    extends ModularState<ReceitaFormPage, ReceitaFormController> {
  Future<Null> load;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Receita receita = ModalRoute.of(context).settings.arguments;
    if (receita != null) controller.receita = receita;
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
      title: Text(controller.receita.id != null && controller.receita.id != 0
          ? "Editar Receita"
          : "Nova Receita"),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          onPressed: onPressedSaveReceita,
          icon: Icon(Icons.save),
        ),
      ],
    );
  }

  Widget getBody() {
    const padding = 16.0;

    return FutureBuilder(
      future: loading(),
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Form(
                    key: controller.formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: padding),
                      child: TextFormFieldCustom(
                        labelText: "Título",
                        initialValue: controller.receita.titulo,
                        onSaved: (value) => controller.receita.titulo = value,
                        validators: [Validator.required()],
                      ),
                    ),
                  ),
                  ReceitaDots(
                    currentyIndex: controller.currentyIndex,
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
      },
    );
  }

  void onPressedSaveReceita() {
    DialogCustom.showProgress(context);
    controller.save().then((response) {
      // var receitaListController = Modular.get<ReceitaListController>();
      // receitaListController.update();

      Navigator.pop(context);
      // Modular.to.pop(true);
    }).catchError((error) {
      print(error);
      Navigator.pop(context);
      // DialogCustom.showAlertDialogUtil(
      //   context,
      //   "Atenção",
      //   error,
      // );
    });
  }

  Future<void> onPageChangedPageView(int index) async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      controller.currentyIndex = index;
    });
  }

  Future<Null> loading() {
    if (load == null) load = controller.load();
    return load;
  }
}
