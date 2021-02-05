import 'package:flutter/material.dart';
import '../../screens/auth_screens/auth_choose_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWithLogoutButton extends StatefulWidget {
  @override
  _AppBarWithLogoutButtonState createState() => _AppBarWithLogoutButtonState();
}

class _AppBarWithLogoutButtonState extends State<AppBarWithLogoutButton> {
  _logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => AuthChooseScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          "assets/images/horizontal_logo.png",
          width: 200,
          height: 50,
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () => _logOut(context),
        ),
      ],
    );
  }
}
