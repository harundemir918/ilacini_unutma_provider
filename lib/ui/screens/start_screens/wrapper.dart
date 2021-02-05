import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/auth_screens/auth_choose_screen.dart';
import '../panels/panel_main_screen.dart';
import '../../screens/start_screens/onboarding_screen.dart';

class Wrapper extends StatefulWidget {
  static const routeName = "/wrapper";

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool onBoardingShown = false;
  bool loggedIn = false;

  @override
  void initState() {
    _getNavigateScreen();
    super.initState();
  }

  _getNavigateScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      onBoardingShown = prefs.getBool('onBoardingShown') ?? false;
      loggedIn = prefs.getBool('loggedIn') ?? false;
    });
    print("onBoardingShown: $onBoardingShown / loggedIn: $loggedIn");
  }

  @override
  Widget build(BuildContext context) {
    print("$onBoardingShown $loggedIn");
    if (onBoardingShown == false) {
      return OnBoardingScreen();
    } else if (loggedIn == false) {
      return AuthChooseScreen();
    } else {
      return PanelMainScreen();
    }
  }
}
