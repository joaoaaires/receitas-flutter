import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:receitas/app/modules/receita/page/widget/receita_dots.dart';
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
  //use 'controller' variable to access controller

  int _currentyIndex;

  @override
  void initState() {
    super.initState();
    this._currentyIndex = 0;
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
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: TextFormFieldCustom(
              labelText: "Título",
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChangedPageView,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: padding, right: padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: padding, right: padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          ReceitaDots(
            currentyIndex: _currentyIndex,
            sizePage: 2,
          ),
        ],
      ),
    );
  }

  void onPageChangedPageView(index) {
    setState(() {
      _currentyIndex = index;
    });
  }

}
