import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../model/receita.dart';
import 'receita_list_controller.dart';

class ReceitaListPage extends StatefulWidget {
  final String title;

  const ReceitaListPage({Key key, this.title = "Receitas"}) : super(key: key);

  @override
  _ReceitaListPageState createState() => _ReceitaListPageState();
}

class _ReceitaListPageState extends State<ReceitaListPage> {
  ReceitaListController _receitaListController;

  @override
  void initState() {
    super.initState();
    _receitaListController = Modular.get<ReceitaListController>();
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
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  Widget getBody() {
    return Observer(
      builder: (_) {
        if (_receitaListController.receitas.error != null) {
          return Center(
            child: Text("Não foi possível carregar receitas!"),
          );
        }

        if (_receitaListController.receitas.value == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Receita> receitas = _receitaListController.receitas.value;

        var size = receitas.length + 1;
        var isEmpty = receitas.isEmpty;

        if (isEmpty) size = size + 1;

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: size,
          itemBuilder: (_, index) {
            if (index == 0) return getButtonNovaReceita();
            if (index == 1 && isEmpty) return getItemMensagemInfo();

            return getItemReceita(receitas[index - 1]);
          },
        );
      },
    );
  }

  Widget getButtonNovaReceita() {
    var borderRadius = BorderRadius.circular(4.0);
    var heightScreen = MediaQuery.of(context).size.height;

    return Material(
      elevation: 3.0,
      borderRadius: borderRadius,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => Modular.to.pushNamed("/receita/form"),
        child: Container(
          color: Colors.transparent,
          height: heightScreen * 0.3,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -30,
                right: -15,
                child: Image.asset(
                  "assets/batedeira.png",
                  color: Color(0xFFF15E5E),
                  height: heightScreen * 0.25,
                  width: heightScreen * 0.25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text.rich(TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "Nova"),
                        TextSpan(text: "\nReceita"),
                      ],
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text.rich(TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Clique aqui para criar"),
                            TextSpan(text: "\numa nova receita"),
                          ],
                          style: TextStyle(
                            fontSize: 13.0,
                          ),
                        )),
                        Icon(
                          Icons.chevron_right,
                          size: 38.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getItemReceita(Receita receita) {
    var sigla = receita.titulo.substring(0, 1);
    var borderRadius = BorderRadius.circular(4.0);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () => onTapItemReceita(receita),
          borderRadius: borderRadius,
          child: ListTile(
            title: Text(receita.titulo),
            subtitle: Text("Receita"),
            leading: CircleAvatar(
              child: Text(sigla),
            ),
          ),
        ),
      ),
    );
  }

  Widget getItemMensagemInfo() {
    var borderRadius = BorderRadius.circular(4.0);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          child: ListTile(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '''Você ainda não possui receitas cadastradas. Clique no botão acima para criar uma nova receita.''',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapItemReceita(Receita receita) {
    Modular.to.pushNamed(
      "/receita/checklist",
      arguments: receita,
    );
  }
}
