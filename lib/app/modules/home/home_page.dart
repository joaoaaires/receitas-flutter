import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Receitas"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        getCardPrincipal(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        getCardItem(),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget getCardPrincipal() {
    double heightScreen = MediaQuery.of(context).size.height;
    TextStyle textStyleTitle = TextStyle(
      fontSize: 23.0,
      fontWeight: FontWeight.bold,
    );
    TextStyle textStyleSubTitle = TextStyle(
      fontSize: 13.0,
    );

    return Container(
      height: heightScreen * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () => Modular.to.pushNamed("/receita/form"),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -30,
                right: -15,
                child: Image.asset(
                  "assets/batedeira.png",
                  color:  Color(0xFFF15E5E),
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
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "Nova",
                      style: textStyleTitle,
                    ),
                    Text(
                      "Receita",
                      style: textStyleTitle,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Clique aqui para criar",
                              style: textStyleSubTitle,
                            ),
                            Text(
                              "uma nova receita",
                              style: textStyleSubTitle,
                            )
                          ],
                        ),
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

  Widget getCardItem() {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(3.0),
          onTap: () {},
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
