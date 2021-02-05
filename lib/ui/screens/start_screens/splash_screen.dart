import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';

import '../../screens/start_screens/wrapper.dart';

import '../../../constants.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash-screen";

  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: "assets/images/splash_logo.png",
      backGroundColor: primaryColor,
      animationEffect: "fade-in",
      logoSize: 200,
      home: Wrapper(),
      duration: 2000,
      type: CustomSplashType.StaticDuration,
    );
  }
}
