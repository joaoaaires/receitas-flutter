import 'package:flutter/material.dart';

class DialogCustom {
  /// EXIBE UM DIALOG PARA O USUARIO FICAR ESPERANDO
  static void showProgress(context, text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text(text),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// EXIBE UM DIALOG DE ALERTA PARA USUARIO
  static void showAlertDialogUtil(context, title, List<String> texts) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: List.generate(texts.length, (index) {
                return Text(texts[index]);
              }),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
