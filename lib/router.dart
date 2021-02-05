import 'package:flutter/material.dart';

import 'ui/screens/start_screens/splash_screen.dart';
import 'ui/screens/start_screens/onboarding_screen.dart';
import 'ui/screens/auth_screens/auth_choose_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case onBoardingScreenRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
        break;
      case authChooseScreenRoute:
        return MaterialPageRoute(builder: (_) => AuthChooseScreen());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Sayfa hatası.'),
            ),
          ),
        );
    }
  }
}

const String splashScreenRoute = '/splash-screen';
const String onBoardingScreenRoute = '/onboarding-screen';
const String authChooseScreenRoute = '/auth-choose-screen';