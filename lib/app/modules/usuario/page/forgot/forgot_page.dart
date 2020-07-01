import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/util/validator/validator.dart';
import '../../../shared/widget/dialog_custom.dart';
import '../../../shared/widget/logo_custom.dart';
import '../../../shared/widget/text_form_field_custom.dart';
import '../../model/usuario_form.dart';
import '../../usuario_controller.dart';


class ForgotPage extends StatefulWidget {
  final String title;
  const ForgotPage({Key key, this.title = "Forgot"}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends ModularState<ForgotPage, UsuarioController> {
  Color colorLogo;
  bool isLoading = false;
  double statusBarHeight;
  final UsuarioForm _usuarioForm = UsuarioForm();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    colorLogo = Theme.of(context).primaryColor;
    statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: BoxDecoration(color: Colors.white)),
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      LogoCustom(color: colorLogo),
                      SizedBox(height: 8),
                      _getForm(),
                      SizedBox(height: 8),
                      _getButton(),
                      SizedBox(height: 8),
                      _getLink(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: statusBarHeight,
        ),
        TextFormFieldCustom(
          labelText: "E-mail",
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _usuarioForm.email = value,
          validators: [
            Validator.required(),
            Validator.email(),
          ],
          inputFormatters: [
            LengthLimitingTextInputFormatter(255),
          ],
        ),
      ],
    );
  }

  Widget _getButton() {
    return Container(
      width: double.maxFinite,
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        onPressed: () => isLoading ? null : _onPressCadastrar(),
        color: Theme.of(context).primaryColor,
        child: Text(
          "ENVIAR",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _getLink() {
    return Container(
      width: double.maxFinite,
      child: FlatButton(
        child: Text(
          "VOLTAR",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () => Navigator.pop(context),
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
  
  void _onPressCadastrar() {
    if (isLoading) {
      return;
    }
    onLoading();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DialogCustom.showProgress(context);
      FocusScope.of(context).requestFocus(FocusNode());

      controller.forgot(_usuarioForm).then(
            (value) {
          Navigator.pop(context);
          DialogCustom.showAlertDialogUtil(
            context,
            "Sucesso!",
            value,
          );
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
      ).whenComplete(
             offLoading
      );
    } else {
      offLoading();
    }
  }
}
