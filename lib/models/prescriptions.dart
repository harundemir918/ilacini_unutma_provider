import 'dart:convert';

Prescriptions prescriptionsFromJson(String str) => Prescriptions.fromJson(json.decode(str));

String prescriptionsToJson(Prescriptions data) => json.encode(data.toJson());

class Prescriptions {
  Prescriptions({
    this.users,
    this.count,
  });

  List<Prescription> users;
  int count;

  factory Prescriptions.fromJson(Map<String, dynamic> json) => Prescriptions(
    users: List<Prescription>.from(json["users"].map((x) => Prescription.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "count": count,
  };
}

class Prescription {
  Prescription({
    this.id,
    this.doctorId,
    this.patientId,
    this.prescriptionCount,
    this.createDate,
  });

  int id;
  int doctorId;
  int patientId;
  int prescriptionCount;
  DateTime createDate;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
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

class PatientPrescription {
  PatientPrescription({
    this.id,
    this.doctorId,
    this.patientId,
    this.medicineId,
    this.code,
    this.name,
    this.surname,
    this.medicineName,
    this.morningNumber,
    this.morningTime,
    this.noonNumber,
    this.noonTime,
    this.eveningNumber,
    this.eveningTime,
    this.createDate,
  });

  int id;
  int doctorId;
  int patientId;
  int medicineId;
  String code;
  String name;
  String surname;
  String medicineName;
  int morningNumber;
  String morningTime;
  int noonNumber;
  String noonTime;
  int eveningNumber;
  String eveningTime;
  DateTime createDate;

  factory PatientPrescription.fromJson(Map<String, dynamic> json) => PatientPrescription(
    id: int.parse(json["id"]),
    doctorId: int.parse(json["doctor_id"]),
    patientId: int.parse(json["patient_id"]),
    medicineId: int.parse(json["medicine_id"]),
    code: json["code"],
    name: json["name"],
    surname: json["surname"],
    medicineName: json["medicine_name"],
    morningNumber: int.parse(json["morning_number"]),
    morningTime: json["morning_time"],
    noonNumber: int.parse(json["noon_number"]),
    noonTime: json["noon_time"],
    eveningNumber: int.parse(json["evening_number"]),
    eveningTime: json["evening_time"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "medicine_id": medicineId,
    "code": code,
    "name": name,
    "surname": surname,
    "medicine_name": medicineName,
    "morning_number": morningNumber,
    "morning_time": morningTime,
    "noon_number": noonNumber,
    "noon_time": noonTime,
    "evening_number": eveningNumber,
    "evening_time": eveningTime,
    "create_date": createDate.toIso8601String(),
  };
}
