import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

import '../models/users.dart';
import '../constants.dart';

class UsersProvider with ChangeNotifier {
  List<User> _doctors;
  List<User> _patients;
  bool _isTrue;
  bool _patientIsReady;

  List<User> get doctorsList => _doctors;
  List<User> get patientsList => _patients;
  bool get isLoggedIn => _isTrue;
  bool get isPatientReady => _patientIsReady;

  set doctorsList(List<User> val) {
    _doctors = val;
    notifyListeners();
  }

  set patientsList(List<User> val) {
    _patients = val;
    notifyListeners();
  }

  set isLoggedIn(bool val) {
    _isTrue = val;
    notifyListeners();
  }

  set isPatientReady(bool val) {
    _patientIsReady = val;
    notifyListeners();
  }

  Future<List<User>> fetchDoctors() async {
    var response = await http.get("$apiUrl/users.php?type=1");
    if (response.statusCode == 200) {
      var mapResponse = convert.jsonDecode(response.body);
      List doctors = mapResponse["users"].cast<Map<String, dynamic>>();
      print(doctors);
      List<User> allDoctors = doctors.map<User>((json) {
        return User.fromJson(json);
      }).toList();
      doctorsList = allDoctors;
      return doctorsList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<bool> logInAsDoctor({String username, String password}) async {
    var response = await http.get("$apiUrl/users.php?type=1");
    if (response.statusCode == 200) {
      var mapResponse = convert.jsonDecode(response.body);
      List doctors = mapResponse["users"].cast<Map<String, dynamic>>();
      print(doctors);
      List<User> allDoctors = doctors.map<User>((json) {
        return User.fromJson(json);
      }).toList();
      doctorsList = allDoctors;
      int count = int.parse(mapResponse["count"].toString());
      for (int i = 0; i < count; i++) {
        var passMD5 =
        crypto.md5.convert(convert.utf8.encode(password)).toString();
        _isTrue = username == doctorsList[i].username &&
            passMD5 == doctorsList[i].password;
        if (_isTrue) {
          break;
        }
      }
      return _isTrue;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<bool> fetchPatients() async {
    var response = await http.get("$apiUrl/users.php?type=2");
    if (response.statusCode == 200) {
      var mapResponse = convert.jsonDecode(response.body);
      List patients = mapResponse["users"].cast<Map<String, dynamic>>();
      print(patients);
      List<User> allPatients = patients.map<User>((json) {
        return User.fromJson(json);
      }).toList();
      patientsList = allPatients;
      isPatientReady = true;
      return isPatientReady;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<bool> logInAsPatient({String username, String password}) async {
    var response = await http.get("$apiUrl/users.php?type=2");
    if (response.statusCode == 200) {
      var mapResponse = convert.jsonDecode(response.body);
      List patients = mapResponse["users"].cast<Map<String, dynamic>>();
      print(patients);
      List<User> allDoctors = patients.map<User>((json) {
        return User.fromJson(json);
      }).toList();
      patientsList = allDoctors;
      int count = int.parse(mapResponse["count"].toString());
      for (int i = 0; i < count; i++) {
        var passMD5 =
        crypto.md5.convert(convert.utf8.encode(password)).toString();
        _isTrue = username == patientsList[i].username &&
            passMD5 == patientsList[i].password;
        if (_isTrue) {
          break;
        }
      }
      return _isTrue;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
