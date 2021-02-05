import 'dart:convert';

Patients patientsFromJson(String str) => Patients.fromJson(json.decode(str));

String patientsToJson(Patients data) => json.encode(data.toJson());

class Patients {
  Patients({
    this.users,
    this.count,
  });

  List<Patient> users;
  int count;

  factory Patients.fromJson(Map<String, dynamic> json) => Patients(
    users: List<Patient>.from(json["users"].map((x) => Patient.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "count": count,
  };
}

class Patient {
  Patient({
    this.id,
    this.doctorId,
    this.patientId,
    this.prescriptionCount,
    this.createDate,
  });

  String id;
  String doctorId;
  String patientId;
  String prescriptionCount;
  DateTime createDate;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    prescriptionCount: json["prescription_count"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "prescription_count": prescriptionCount,
    "create_date": createDate.toIso8601String(),
  };
}

class DoctorPatient {
  DoctorPatient({
    this.doctorId,
    this.patientId,
    this.name,
    this.surname,
    this.devicePlayerId,
    this.prescriptionCount,
  });

  String doctorId;
  String patientId;
  String name;
  String surname;
  String devicePlayerId;
  String prescriptionCount;

  factory DoctorPatient.fromJson(Map<String, dynamic> json) => DoctorPatient(
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    name: json["name"],
    surname: json["surname"],
    devicePlayerId: json["device_player_id"],
    prescriptionCount: json["prescription_count"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "patient_id": patientId,
    "name": name,
    "surname": surname,
    "device_player_id": devicePlayerId,
    "prescription_count": prescriptionCount,
  };
}
