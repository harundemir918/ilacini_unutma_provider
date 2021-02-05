import 'package:flutter/material.dart';
import '../../widgets/blue_square_button.dart';

import 'auth_doctor_sign_in_screen.dart';
import 'auth_patient_sign_in_screen.dart';
import 'auth_register_screen.dart';

class AuthChooseScreen extends StatelessWidget {
  static const routeName = "/auth-choose-screen";

  void getAuthDoctorSignInScreen(BuildContext context, int type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthDoctorSignInScreen(type: 1),
      ),
    );
  }

  void getAuthPatientSignInScreen(BuildContext context, int type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthPatientSignInScreen(type: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                ),
                child: Image.asset("assets/images/splash_logo.png"),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlueSquareButton(
                      title: "Doktor Girişi",
                      function: () => getAuthDoctorSignInScreen(context, 1),
                    ),
                    BlueSquareButton(
                      title: "Hasta Girişi",
                      function: () => getAuthPatientSignInScreen(context, 2),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hesabınız yok mu?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Kayıt olun.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AuthRegisterScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
