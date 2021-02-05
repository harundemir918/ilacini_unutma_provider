import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '../../../constants.dart';
import '../auth_screens/auth_choose_screen.dart';
import 'panel_doctor_patients_screen.dart';
import 'panel_doctor_prescriptions_screen.dart';
import 'panel_taken_medicines_screen.dart';
import '../../widgets/app_bar/app_bar_with_logout_button.dart';
import '../../widgets/blue_square_button.dart';

class PanelMainScreen extends StatefulWidget {
  @override
  _PanelMainScreenState createState() => _PanelMainScreenState();
}

class _PanelMainScreenState extends State<PanelMainScreen> {
  int uid;
  int doctorUid;
  String user;
  int type;

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getInt('uid');
      user = prefs.getString('user');
      type = prefs.getInt('type');
    });

    if (type == 2) {
      var url = "$apiUrl/patient.php?patient_id=$uid";

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        doctorUid = int.parse(jsonResponse["users"][0]["doctor_id"].toString());
        print(jsonResponse["users"][0]);
        setState(() {
          prefs.setInt("doctorUid", doctorUid);
        });
        print("doc: $doctorUid");
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setBool("loggedIn", false);
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthChooseScreen()));
  }

  void getPanelDoctorPatientsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PanelDoctorPatientsScreen(),
      ),
    );
  }

  void getPanelDoctorPrescriptionsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PanelDoctorPrescriptionsScreen(),
      ),
    );
  }

  void getPanelTakenMedicinesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PanelTakenMedicinesScreen(),
      ),
    );
  }

  Widget _buildDoctorPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarWithLogoutButton(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 75),
          child: Text(
            "Merhaba, $user.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlueSquareButton(
                  title: "Hastalarım",
                  function: () => getPanelDoctorPatientsScreen(context),
                ),
                BlueSquareButton(
                  title: "Reçetelerim",
                  function: () => getPanelDoctorPrescriptionsScreen(context),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlueSquareButton(
                  title: "İlaç Alım Bilgisi",
                  function: () => getPanelTakenMedicinesScreen(context),
                ),
                BlueSquareButton(
                  title: "Bilgilerim",
                  function: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatientPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarWithLogoutButton(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 75),
          child: Text(
            "Merhaba, $user.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlueSquareButton(
                  title: "Reçetelerim",
                  function: () => getPanelDoctorPrescriptionsScreen(context),
                ),
                BlueSquareButton(
                  title: "Bilgilerim",
                  function: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Uid: $uid");
    print("DoctorUid = $doctorUid");
    print("Type: $type");
    return Scaffold(
      body: SafeArea(
        child: DoubleBackToCloseApp(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: type == 1
                ? _buildDoctorPanel(context)
                : _buildPatientPanel(context),
          ),
          snackBar: const SnackBar(
            content: Text("Uygulamadan çıkmak için tekrar dokunun."),
          ),
        ),
      ),
    );
  }
}
