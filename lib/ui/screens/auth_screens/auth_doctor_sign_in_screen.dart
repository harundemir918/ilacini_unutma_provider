import 'package:flutter/material.dart';

import '../../widgets/sign_in/sign_in.dart';

class AuthDoctorSignInScreen extends StatefulWidget {
  final int type;

  AuthDoctorSignInScreen({this.type});

  @override
  _AuthDoctorSignInScreenState createState() => _AuthDoctorSignInScreenState();
}

class _AuthDoctorSignInScreenState extends State<AuthDoctorSignInScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/splash_logo.png",
              width: 200,
              height: 150,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Doktor Girişi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SignIn(type: widget.type,),
          ],
        ),
      ),
    );
  }
}
