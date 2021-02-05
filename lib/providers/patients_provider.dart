import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/patients.dart';
import '../constants.dart';

enum LoadData {
  loaded,
  notLoaded,
  waiting,
}

class PatientsProvider with ChangeNotifier {
  List<DoctorPatient> _patients;
  LoadData _patientIsReady;

  List<DoctorPatient> get patientsList => _patients;
  LoadData get isPatientReady => _patientIsReady;

  set patientsList(List<DoctorPatient> val) {
    _patients = val;
    notifyListeners();
  }

  set isPatientReady(LoadData val) {
    _patientIsReady = val;
    notifyListeners();
  }

  Future<LoadData> fetchPatients(int doctorUid) async {
    try {
      var response = await http.get("$apiUrl/patient.php?doctor_id=$doctorUid");
      if (response.statusCode == 200) {
        var mapResponse = convert.jsonDecode(response.body);
        List patients = mapResponse["users"].cast<Map<String, dynamic>>();
        print(patients);
        List<DoctorPatient> allPatients = patients.map<DoctorPatient>((json) {
          return DoctorPatient.fromJson(json);
        }).toList();
        patientsList = allPatients;
        isPatientReady = LoadData.loaded;
      } else {
        isPatientReady = LoadData.notLoaded;
      }
    } catch(e) {
      isPatientReady = LoadData.notLoaded;
      debugPrint(e.toString());
    }

    return isPatientReady;
  }
}