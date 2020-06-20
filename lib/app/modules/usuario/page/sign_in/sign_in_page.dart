import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shareds/utils/validator/validator.dart';
import '../../../../shareds/widgets/dialog_custom.dart';
import '../../../../shareds/widgets/text_form_field_custom.dart';
import '../../model/usuario_form.dart';
import '../../usuario_controller.dart';

class SignInPage extends StatefulWidget {
  final String title;

  const SignInPage({Key key, this.title = "SignIn"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, UsuarioController> {
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
                      _getForm(),
                      SizedBox(height: 8),
                      _getButton(),
                      SizedBox(height: 8),
                      _getLink(),
                      _getFogot()
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
        SizedBox(height: 8),
        TextFormFieldCustom(
          labelText: "Senha",
          keyboardType: TextInputType.text,
          onSaved: (value) => _usuarioForm.senha = value,
          obscureText: true,
          validators: [
            Validator.required(),
            Validator.minLength(5),
          ],
          inputFormatters: [],
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
          "ENTRAR",
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
          "CADASTRAR",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () => Navigator.pushNamed(context, '/usuario/signup'),
      ),
    );
  }

  Widget _getFogot() {
    return Container(
      width: double.maxFinite,
      child: FlatButton(
        child: Text(
          "ESQUECI MINHA SENHA",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () => Navigator.pushNamed(context, '/usuario/forgot'),
      ),
    );
  }

  void setLoading(bool state) {
    isLoading = state;
    setState(() {});
  }

  void _onPressCadastrar() {
    if (isLoading) {
      return;
    }
    setLoading(true);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DialogCustom.showProgress(context);
      FocusScope.of(context).requestFocus(FocusNode());

      controller.signin(_usuarioForm).then(
        (value) {
          Navigator.pop(context);
          Modular.to.pushReplacementNamed('/home');
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
        () => setLoading(false),
      );
    } else {
      setLoading(false);
    }
  }
}
