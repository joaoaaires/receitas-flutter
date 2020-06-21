import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final String text;
  final double width;
  final double heigth;
  final Color colorText;
  final Color colorButtom;
  final Color colorIcon;
  final IconData icon;
  final GestureTapCallback onTap;
  final BorderRadius borderRadius = BorderRadius.circular(4.0);

  ButtomCustom({
    Key key,
    this.text,
    this.colorText,
    this.width,
    this.heigth = 58.0,
    this.colorButtom,
    this.colorIcon,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      color: colorButtom,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          color: Colors.transparent,
          height: heigth,
          width: width,
          alignment: Alignment.center,
          child: getChildButtom(),
          // child: Icon(
          //   icon,
          //   color: colorIcon,
          //   size: 24,
          // ),
        ),
      ),
    );
  }

  Widget getChildButtom() {
    if (text != null) {
      return Text(
        text,
        style: TextStyle(color: colorText),
      );
    }

    if (icon != null) {
      return Icon(
        icon,
        color: colorIcon,
        size: 24,
      );
    }

    return Container();
  }
}
