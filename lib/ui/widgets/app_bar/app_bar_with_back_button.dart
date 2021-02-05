import 'package:flutter/material.dart';

class AppBarWithBackButton extends StatelessWidget {
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () => goBack(context),
        ),
        Image.asset(
          "assets/images/horizontal_logo.png",
          width: 200,
          height: 50,
        ),
      ],
    );
  }
}
