import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReceitaListPage extends StatefulWidget {
  final String title;

  const ReceitaListPage({Key key, this.title = "Receitas"}) : super(key: key);

  @override
  _ReceitaListPageState createState() => _ReceitaListPageState();
}

class _ReceitaListPageState extends State<ReceitaListPage> {
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
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.star),
        ),
      ],
    );
  }

  Widget getBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        getButtonNovaReceita(),
        getItemReceita(),
      ],
    );
  }

  Widget getButtonNovaReceita() {
    BorderRadius borderRadius = BorderRadius.circular(5.0);
    double heightScreen = MediaQuery.of(context).size.height;

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

  Widget getItemReceita() {
    BorderRadius borderRadius = BorderRadius.circular(5.0);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () {},
          borderRadius: borderRadius,
          child: ListTile(
            title: Text("Bolo"),
            subtitle: Text("Bolo Dois"),
            leading: CircleAvatar(),
          ),
        ),
      ),
    );
  }
}
