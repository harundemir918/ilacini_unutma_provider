import 'package:flutter/material.dart';

import '../../../constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(
          secondaryColor,
        ),
      ),
    );
  }
}
