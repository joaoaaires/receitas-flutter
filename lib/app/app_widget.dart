import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFF79A87,
          {
            50: Color.fromRGBO(247, 154, 135, .1),
            100: Color.fromRGBO(247, 154, 135, .2),
            200: Color.fromRGBO(247, 154, 135, .3),
            300: Color.fromRGBO(247, 154, 135, .4),
            400: Color.fromRGBO(247, 154, 135, .5),
            500: Color.fromRGBO(247, 154, 135, .6),
            600: Color.fromRGBO(247, 154, 135, .7),
            700: Color.fromRGBO(247, 154, 135, .8),
            800: Color.fromRGBO(247, 154, 135, .9),
            900: Color.fromRGBO(247, 154, 135, 1),
          },
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
