import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'receita_checklist_controller.dart';

class ReceitaChecklistPage extends StatefulWidget {
  final String title;
  const ReceitaChecklistPage({Key key, this.title = "Receita"})
      : super(key: key);

  @override
  _ReceitaChecklistPageState createState() => _ReceitaChecklistPageState();
}

class _ReceitaChecklistPageState
    extends ModularState<ReceitaChecklistPage, ReceitaChecklistController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
//          onPressed: onPressedSaveReceita,
        onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
      ],
    );
  }

}
