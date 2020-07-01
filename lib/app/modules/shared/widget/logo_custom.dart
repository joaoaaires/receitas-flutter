import 'package:flutter/material.dart';

class LogoCustom extends StatelessWidget {

  final Color color;

  const LogoCustom({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            scale: 4.5,
            color: color,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "Receitas",
              style: TextStyle(
                color: color,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Assistant",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text(
              "S A V E  R E C E I T A",
              style: TextStyle(
                color: color,
                fontSize: 10.0,
                fontFamily: "Heebo",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
