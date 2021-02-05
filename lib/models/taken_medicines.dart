import 'dart:convert';

TakenMedicines takenMedicinesFromJson(String str) => TakenMedicines.fromJson(json.decode(str));

String takenMedicinesToJson(TakenMedicines data) => json.encode(data.toJson());

class TakenMedicines {
  TakenMedicines({
    this.the200,
    this.error,
    this.users,
    this.count,
  });

  String the200;
  bool error;
  List<TakenMedicine> users;
  int count;

  factory TakenMedicines.fromJson(Map<String, dynamic> json) => TakenMedicines(
    the200: json["200"],
    error: json["error"],
    users: List<TakenMedicine>.from(json["users"].map((x) => TakenMedicine.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "200": the200,
    "error": error,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "count": count,
  };
}

class TakenMedicine {
  TakenMedicine({
    this.id,
    this.doctorId,
    this.patientId,
    this.medicineId,
    this.prescriptionCode,
    this.timeToTake,
  });

  String id;
  String doctorId;
  String patientId;
  String medicineId;
  String prescriptionCode;
  DateTime timeToTake;

  factory TakenMedicine.fromJson(Map<String, dynamic> json) => TakenMedicine(
    id: json["id"],
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    medicineId: json["medicine_id"],
    prescriptionCode: json["prescription_code"],
    timeToTake: DateTime.parse(json["time_to_take"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "medicine_id": medicineId,
    "prescription_code": prescriptionCode,
    "time_to_take": timeToTake.toIso8601String(),
  };
}

class DoctorTakenMedicine {
  DoctorTakenMedicine({
    this.id,
    this.doctorId,
    this.patientId,
    this.name,
    this.surname,
    this.medicineId,
    this.medicineName,
    this.prescriptionCode,
    this.timeToTake,
  });

  String id;
  String doctorId;
  String patientId;
  String name;
  String surname;
  String medicineId;
  String medicineName;
  String prescriptionCode;
  DateTime timeToTake;

  factory DoctorTakenMedicine.fromJson(Map<String, dynamic> json) => DoctorTakenMedicine(
    id: json["id"],
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    name: json["name"],
    surname: json["surname"],
    medicineId: json["medicine_id"],
    medicineName: json["medicine_name"],
    prescriptionCode: json["prescription_code"],
    timeToTake: DateTime.parse(json["time_to_take"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "name": name,
    "surname": surname,
    "medicine_id": medicineId,
    "medicine_name": medicineName,
    "prescription_code": prescriptionCode,
    "time_to_take": timeToTake.toIso8601String(),
  };
}
