import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/util/validator/validator.dart';
import '../../../shared/widget/dialog_custom.dart';
import '../../../shared/widget/text_form_field_custom.dart';
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
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwdOldController = TextEditingController();
  final TextEditingController _passwdNewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text("Alterar Senha"),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          onPressed: () => isLoading ? null : onPressedSaved(),
          icon: Icon(Icons.save),
        ),
      ],
    );
  }

  Widget getBody() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextFormFieldCustom(
              labelText: "Senha Atual",
              controller: _passwdOldController,
              obscureText: true,
              validators: [
                Validator.required(),
              ],
            ),
            SizedBox(height: 8),
            TextFormFieldCustom(
              labelText: "Nova Senha",
              keyboardType: TextInputType.text,
              controller: _passwdNewController,
              obscureText: true,
              validators: [
                Validator.required(),
                Validator.minLength(5),
              ],
              inputFormatters: [],
            ),
            SizedBox(height: 8),
            TextFormFieldCustom(
              labelText: "Confirmação de Nova Senha",
              obscureText: true,
              validators: [
                Validator.required(),
                (value) => (value != _passwdNewController.text)
                    ? "Senha não corresponde"
                    : null,
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onLoading() {
    isLoading = true;
    setState(() {});
  }

  void offLoading() {
    isLoading = false;
    setState(() {});
  }

  void onPressedSaved() {
    if (isLoading) {
      return;
    }
    onLoading();
    if (_formKey.currentState.validate()) {
      DialogCustom.showProgress(context);
      FocusScope.of(context).requestFocus(FocusNode());

      controller
          .change(
        _passwdOldController.text,
        _passwdNewController.text,
      )
          .then(
        (value) {
          Navigator.pop(context);
          Modular.to.pop();
        },
      ).catchError(
        (error) {
          Navigator.pop(context);
          DialogCustom.showAlertDialogUtil(
            context,
            "Atenção",
            error.message,
          );
        },
      ).whenComplete(offLoading);
    } else {
      offLoading();
    }
  }
}
