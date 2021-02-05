import 'package:flutter/material.dart';

import '../../constants.dart';

class BlueSquareButton extends StatelessWidget {
  final String title;
  final Function function;

  BlueSquareButton({this.title, this.function});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: function,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 125,
          width: 125,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
