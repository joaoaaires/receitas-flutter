import 'package:flutter/material.dart';

class ReceitaDots extends StatelessWidget {
  final int sizePage;
  final int currentyIndex;

  const ReceitaDots({
    Key key,
    this.sizePage = 1,
    this.currentyIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          sizePage,
          (index) {
            return Row(
              children: <Widget>[
                index != 0 ? SizedBox(width: 8) : SizedBox.shrink(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: getColor(context, index),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color getColor(BuildContext context, int index) {
    return index == currentyIndex
        ? Theme.of(context).primaryColor
        : Colors.grey;
  }
}
