import 'package:flutter/material.dart';

class DialogCustom {
  /// EXIBE UM DIALOG PARA O USUARIO FICAR ESPERANDO
  static void showProgress(
    BuildContext context, {
    String text = "Aguarde...",
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
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
  static void showAlertDialogUtil(
    BuildContext context,
    String title,
    String text,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
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
