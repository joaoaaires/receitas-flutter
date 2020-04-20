import 'package:flutter/material.dart';

class AppChildCustom extends InheritedWidget {
  final Widget child;
  String _olaMundoAgoraVaiRolar;

  AppChildCustom({this.child}) : super(child: child);

  static AppChildCustom of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppChildCustom>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget != this;
  }

  set olaMundoAgoraVaiRolar(String value) =>
      this._olaMundoAgoraVaiRolar = value;

  String get olaMundoAgoraVaiRolar => this._olaMundoAgoraVaiRolar;
}
