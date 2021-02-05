import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

import '../../../constants.dart';
import '../panels/panel_main_screen.dart';

class AuthRegisterScreen extends StatefulWidget {
  @override
  _AuthRegisterScreenState createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  int _value = 1;

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        DropdownButtonFormField(
                          value: _value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Doktor Kaydı"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Hasta Kaydı"),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            _value = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[300],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            hintText: "Kullanıcı Adı",
                          ),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[300],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            hintText: "Şifre",
                          ),
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: () async {
                              var url = "$apiUrl/users.php?type=$_value";
                              var response = await http.get(url);
                              if (response.statusCode == 200) {
                                var jsonResponse =
                                    convert.jsonDecode(response.body);
                                int count =
                                    int.parse(jsonResponse["count"].toString());
                                for (int i = 0; i < count; i++) {
                                  var passMD5 = crypto.md5
                                      .convert(convert.utf8.encode(password))
                                      .toString();
                                  print("$username $password $passMD5 $_value");
                                  if (username ==
                                          jsonResponse["users"][i]
                                              ["username"] &&
                                      passMD5 ==
                                          jsonResponse["users"][i]
                                              ["password"]) {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => PanelMainScreen(
                                    //         user: username, type: _value),
                                    //   ),
                                    // );
                                  }
                                }
                              } else {
                                print(
                                    'Request failed with status: ${response.statusCode}.');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
