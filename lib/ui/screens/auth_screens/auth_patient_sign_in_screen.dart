import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../panels/panel_main_screen.dart';
import '../../widgets/sign_in/sign_in.dart';

class AuthPatientSignInScreen extends StatefulWidget {
  final int type;

  AuthPatientSignInScreen({this.type});

  @override
  _AuthPatientSignInScreenState createState() =>
      _AuthPatientSignInScreenState();
}

class _AuthPatientSignInScreenState extends State<AuthPatientSignInScreen> {
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
              "Hasta Girişi",
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
