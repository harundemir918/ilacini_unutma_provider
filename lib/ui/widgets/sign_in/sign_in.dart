import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../providers/users_provider.dart';
import '../../screens/panels/panel_main_screen.dart';

class SignIn extends StatefulWidget {
  final int type;

  SignIn({
    this.type,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  String error = "";
  bool _isLoggedIn = false;

  setLoggedInTrue({int uid, String user, int type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('loggedIn', true);
      prefs.setInt('uid', uid);
      prefs.setString('user', user);
      prefs.setInt('type', type);
    });
  }

  void doctorSignIn({BuildContext context, String username, String password}) async {
    UsersProvider usersProvider =
        Provider.of<UsersProvider>(context, listen: false);
    _isLoggedIn = await usersProvider.logInAsDoctor(
      username: username,
      password: password,
    );
    if (_isLoggedIn) {
      int uid = int.parse(usersProvider.doctorsList
          .where((doctor) => doctor.username == username)
          .first
          .id
          .toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PanelMainScreen(
              /*id: uid, user: username, type: _value*/),
        ),
      );
      setLoggedInTrue(
        uid: uid,
        user: username,
        type: widget.type,
      );
    }
  }

  void patientSignIn({BuildContext context, String username, String password}) async {
    UsersProvider usersProvider =
    Provider.of<UsersProvider>(context, listen: false);
    _isLoggedIn = await usersProvider.logInAsPatient(
      username: username,
      password: password,
    );
    if (_isLoggedIn) {
      int uid = int.parse(usersProvider.patientsList
          .where((patient) => patient.username == username)
          .first
          .id
          .toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PanelMainScreen(
            /*id: uid, user: username, type: _value*/),
        ),
      );
      setLoggedInTrue(
        uid: uid,
        user: username,
        type: widget.type,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    // Text(error),
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
                          if (widget.type == 1) {
                            doctorSignIn(
                              context: context,
                              username: username,
                              password: password,
                            );
                          } else {
                            patientSignIn(
                              context: context,
                              username: username,
                              password: password,
                            );
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
    );
  }
}
