import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/medicines.dart';
import '../constants.dart';

class MedicinesProvider with ChangeNotifier {
  List<Medicine> _medicines;
  bool _medicineIsReady;

  List<Medicine> get medicinesList => _medicines;
  bool get isMedicineReady => _medicineIsReady;

  set medicinesList(List<Medicine> val) {
    _medicines = val;
    notifyListeners();
  }

  set isMedicineReady(bool val) {
    _medicineIsReady = val;
    notifyListeners();
  }

  Future<List<Medicine>> fetchMedicines() async {
    var response = await http.get("$apiUrl/medicines.php");
    if (response.statusCode == 200) {
      var mapResponse = convert.jsonDecode(response.body);
      List medicines = mapResponse["medicines"].cast<Map<String, dynamic>>();
      print(medicines);
      List<Medicine> allMedicines = medicines.map<Medicine>((json) {
        return Medicine.fromJson(json);
      }).toList();
      medicinesList = allMedicines;
      return medicinesList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}