import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'change_passwd_controller.dart';

class ChangePasswdPage extends StatefulWidget {
  final String title;
  const ChangePasswdPage({Key key, this.title = "ChangePasswd"})
      : super(key: key);

  @override
  _ChangePasswdPageState createState() => _ChangePasswdPageState();
}

class _ChangePasswdPageState
    extends ModularState<ChangePasswdPage, ChangePasswdController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
