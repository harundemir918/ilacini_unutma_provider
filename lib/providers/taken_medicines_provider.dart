import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/taken_medicines.dart';
import '../constants.dart';

class TakenMedicinesProvider with ChangeNotifier {
  List<DoctorTakenMedicine> _takenMedicines;
  bool _takenMedicineIsReady;

  List<DoctorTakenMedicine> get takenMedicinesList => _takenMedicines;

  bool get isTakenMedicinesReady => _takenMedicineIsReady;

  set takenMedicinesList(List<DoctorTakenMedicine> val) {
    _takenMedicines = val;
    notifyListeners();
  }

  set isTakenMedicinesReady(bool val) {
    _takenMedicineIsReady = val;
    notifyListeners();
  }

  Future<bool> fetchTakenMedicines({
    int doctorUid,
    int patientUid,
    int type,
  }) async {
    if (type == 1) {
      var response =
          await http.get("$apiUrl/taken_medicines.php?doctor_id=$doctorUid");
      if (response.statusCode == 200) {
        var mapResponse = convert.jsonDecode(response.body);
        List takenMedicines = mapResponse["users"].cast<Map<String, dynamic>>();
        print(takenMedicines);
        List<DoctorTakenMedicine> allTakenMedicines =
            takenMedicines.map<DoctorTakenMedicine>((json) {
          return DoctorTakenMedicine.fromJson(json);
        }).toList();
        takenMedicinesList = allTakenMedicines;
        isTakenMedicinesReady = true;
        return isTakenMedicinesReady;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    }
    return false;
  }
}
