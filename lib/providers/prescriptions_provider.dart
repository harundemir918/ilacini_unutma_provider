import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/prescriptions.dart';
import '../constants.dart';

enum LoadPrescription {
  loaded,
  notLoaded,
  waiting,
}

class PrescriptionsProvider with ChangeNotifier {
  List<PatientPrescription> _prescriptions;
  List<String> _prescriptionCodes = [];
  int _prescriptionCodeCount;
  int _prescriptionCount;
  LoadPrescription _prescriptionIsReady;

  List<PatientPrescription> get prescriptionsList => _prescriptions;
  List<String> get prescriptionCodesList => _prescriptionCodes;
  int get prescriptionCodeListCount => _prescriptionCodeCount;
  int get prescriptionCount => _prescriptionCount;
  LoadPrescription get isPrescriptionReady => _prescriptionIsReady;

  set prescriptionsList(List<PatientPrescription> val) {
    _prescriptions = val;
    notifyListeners();
  }

  set prescriptionCodesList(List<String> val) {
    _prescriptionCodes = val;
    notifyListeners();
  }

  set isPrescriptionReady(LoadPrescription val) {
    _prescriptionIsReady = val;
    notifyListeners();
  }

  set prescriptionCodeListCount(int val) {
    _prescriptionCodeCount = val;
    notifyListeners();
  }

  set prescriptionCount(int val) {
    _prescriptionCount = val;
    notifyListeners();
  }

  Future<LoadPrescription> fetchPatientPrescriptions({int doctorUid, int patientUid}) async {
    try {
      var response = await http.get("$apiUrl/prescriptions.php?doctor_id=$doctorUid&patient_id=$patientUid");
      if (response.statusCode == 200) {
        var mapResponse = convert.jsonDecode(response.body);
        List patients = mapResponse["users"].cast<Map<String, dynamic>>();
        print(patients);
        List<PatientPrescription> allPrescriptions = patients.map<PatientPrescription>((json) {
          return PatientPrescription.fromJson(json);
        }).toList();
        prescriptionsList = allPrescriptions;
        for (var prescription in prescriptionsList) {
          if (!prescriptionCodesList.contains(prescription.code)) {
            prescriptionCodesList.add(prescription.code);
          }
        }
        prescriptionCodeListCount = prescriptionCodesList.length;
        prescriptionCount = prescriptionsList.length;
        isPrescriptionReady = LoadPrescription.loaded;
      } else {
        isPrescriptionReady = LoadPrescription.notLoaded;
      }
    } catch(e) {
      isPrescriptionReady = LoadPrescription.notLoaded;
      debugPrint(e.toString());
    }
    return isPrescriptionReady;
  }

  // Future<int> fetchPatientPrescriptionCountById(int doctorUid, int patientUid) async {
  //   var response = await http.get("$apiUrl/patient.php?doctor_id=$doctorUid&patient_id=$patientUid");
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     var prescriptions = jsonResponse["users"];
  //     // for (var prescription in prescriptions) {
  //     //   if (!prescriptionCodesList.contains(prescriptions[prescription]["code"])) {
  //     //     prescriptionCodesList.add(prescriptions[prescription]["code"]);
  //     //     prescriptionCodeListCount = prescriptionCodesList.length;
  //     //     print(prescriptions[prescription]["code"]);
  //     //   }
  //     // }
  //     List<PatientPrescription> allPrescriptions = prescriptions.map<PatientPrescription>((json) {
  //       return PatientPrescription.fromJson(json);
  //     }).toList();
  //     prescriptionsList = allPrescriptions;
  //     return prescriptionsList.length;
  //   } else {
  //     throw Exception('Request failed with status: ${response.statusCode}.');
  //   }
  // }
}