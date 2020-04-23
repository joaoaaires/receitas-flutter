import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {

  final BorderRadius borderRadius = BorderRadius.circular(5.0);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      color: Colors.green,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {},
        borderRadius: borderRadius,
        child: Container(
          color: Colors.transparent,
          height: 58,
          width: 58,
          alignment: Alignment.center,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
