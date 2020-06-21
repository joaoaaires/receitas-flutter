import 'package:flutter/material.dart';

class AppChildCustom extends InheritedWidget {
  final Widget child;
  final String olaMundoAgoraVaiRolar;

  AppChildCustom({
    this.child,
    this.olaMundoAgoraVaiRolar,
  }) : super(child: child);

  static AppChildCustom of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppChildCustom>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}
