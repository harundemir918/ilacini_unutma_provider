import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../constants.dart';
import '../../services/notification_service.dart';

class AddPrescriptionModalSheet extends StatefulWidget {
  final int doctorUid;
  final int patientUid;
  final String patientDevicePlayerId;

  AddPrescriptionModalSheet({
    this.doctorUid,
    this.patientUid,
    this.patientDevicePlayerId,
  });

  @override
  _AddPrescriptionModalSheetState createState() =>
      _AddPrescriptionModalSheetState();
}

class _AddPrescriptionModalSheetState extends State<AddPrescriptionModalSheet> {
  NotificationService notificationService = NotificationService();
  String code = randomAlphaNumeric(8).toUpperCase();
  List<dynamic> _prescriptions = [];
  List<dynamic> _medicines = [];
  List<DropdownMenuItem> items = [];
  int _count = 1;
  int _value;
  bool medicineIsReady = false;
  String _morningNumber = "0";
  String _noonNumber = "0";
  String _eveningNumber = "0";
  TimeOfDay _morningTime = TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay _noonTime = TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay _eveningTime = TimeOfDay.fromDateTime(DateTime.now());

  @override
  void initState() {
    getMedicines();
    super.initState();
  }

  getMedicines() async {
    var url = "$apiUrl/medicines.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      int count = int.parse(jsonResponse["count"].toString());
      print(jsonResponse["medicines"][0]["id"]);
      print(jsonResponse["medicines"][0]["name"]);
      for (int i = 0; i < count; i++) {
        setState(() {
          _medicines.add({
            "medicineID": jsonResponse["medicines"][i]["id"],
            "medicineName": jsonResponse["medicines"][i]["name"],
            "medicineImage": jsonResponse["medicines"][i]["image"],
          });
          items.add(
            DropdownMenuItem(
              child: Text(jsonResponse["medicines"][i]["name"]),
              value: int.parse(jsonResponse["medicines"][i]["id"]),
            ),
          );
        });
      }
      medicineIsReady = true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  createPrescription({
    String doctorUid,
    String patientUid,
    String medicineUid,
    String morningNumber,
    String morningTime,
    String noonNumber,
    String noonTime,
    String eveningNumber,
    String eveningTime,
    String code,
  }) async {
    var url = "$apiUrl/prescriptions.php";
    var response = await http.post(url, body: {
      'doctor_id': doctorUid,
      'patient_id': patientUid,
      'medicine_id': medicineUid,
      'morning_number': morningNumber,
      'morning_time': morningTime,
      'noon_number': noonNumber,
      'noon_time': noonTime,
      'evening_number': eveningNumber,
      'evening_time': eveningTime,
      'code': code
    });
    if (response.statusCode == 201) {
      print("Ekleme başarılı.");
    } else {
      print("Hata.");
    }
  }

  // createNotification({
  //   String time,
  //   String image,
  // }) async {
  //   var url = "http://api.harundemir.org/ilacini_unutma/create_notification.php";
  //   var response = await http.post(url, body: {
  //     'time': time,
  //     'image_url': image,
  //   });
  //   print(response.body);
  // }

  Future<void> _showMorningTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _morningTime,
    );
    if (picked != null && picked != _morningTime) {
      setState(() {
        _morningTime = picked;
      });
    }
  }

  Future<void> _showNoonTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _noonTime,
    );
    if (picked != null && picked != _noonTime) {
      setState(() {
        _noonTime = picked;
      });
    }
  }

  Future<void> _showEveningTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _eveningTime,
    );
    if (picked != null && picked != _eveningTime) {
      setState(() {
        _eveningTime = picked;
      });
    }
  }

  String get _getMorningTime {
    return _morningTime.format(context);
  }

  String get _getNoonTime {
    return _noonTime.format(context);
  }

  String get _getEveningTime {
    return _eveningTime.format(context);
  }

  Widget _buildMedicine() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            child: DropdownButtonFormField(
              hint: Text("İlaç seçin"),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: medicineIsReady ? items : [],
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sabah",
                style: TextStyle(color: lightGrayColor),
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Adet",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Adet"),
                      initialValue: _morningNumber,
                      onChanged: (val) {
                        _morningNumber = val;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Saat",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: Text(_getMorningTime),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: _showMorningTimePicker,
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Öğle",
                style: TextStyle(color: lightGrayColor),
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Adet",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Adet"),
                      initialValue: _noonNumber,
                      onChanged: (val) {
                        _noonNumber = val;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Saat",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: Text(_getNoonTime),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () => _showNoonTimePicker(),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Akşam",
                style: TextStyle(color: lightGrayColor),
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Adet",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Adet"),
                      initialValue: _eveningNumber,
                      onChanged: (val) {
                        _eveningNumber = val;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    child: Text(
                      "Saat",
                      style: TextStyle(color: lightGrayColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    child: Text(_getEveningTime),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: _showEveningTimePicker,
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onTap: () => _addNewMedicine(
                    doctorUid: widget.doctorUid.toString(),
                    patientUid: widget.patientUid.toString(),
                    medicineUid: _value.toString(),
                    medicineName: _medicines[_value - 1]["medicineName"],
                    morningNumber: _morningNumber,
                    morningTime: _getMorningTime,
                    noonNumber: _noonNumber,
                    noonTime: _getNoonTime,
                    eveningNumber: _eveningNumber,
                    eveningTime: _getEveningTime,
                    image: _medicines[_value - 1]["medicineImage"],
                    code: code),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewMedicine({
    String doctorUid,
    String patientUid,
    String medicineUid,
    String medicineName,
    String morningNumber,
    String morningTime,
    String noonNumber,
    String noonTime,
    String eveningNumber,
    String eveningTime,
    String image,
    String code,
  }) {
    setState(() {
      _prescriptions.add({
        "doctor_id": doctorUid,
        "patient_id": patientUid,
        "medicine_id": medicineUid,
        "medicine_name": medicineName,
        'morning_number': morningNumber,
        'morning_time': morningTime,
        'noon_number': noonNumber,
        'noon_time': noonTime,
        'evening_number': eveningNumber,
        'evening_time': eveningTime,
        'image': image,
        "code": code,
      });
      _count = _count + 1;
    });
  }

  void sendNotification({
    String doctorUid,
    String patientUid,
    String medicineUid,
    String medicineName,
    String image,
    String time,
    String code,
  }) async {
    var playerId = widget.patientDevicePlayerId;

    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: [playerId],
      content: "$medicineName ilacınızı aldınız mı?",
      heading: "İlacını Unutma",
      buttons: [
        OSActionButton(text: "Aldım", id: "taken"),
      ],
      delayedOption: OSCreateNotificationDelayOption.timezone,
      deliveryTimeOfDay: time,
      bigPicture: image,
    ));
  }

  updateTakenMedicines({
    String doctorUid,
    String patientUid,
    String medicineUid,
    String code,
  }) async {
    var url = "$apiUrl/taken_medicines.php";
    var response = await http.post(url, body: {
      'doctor_id': doctorUid,
      'patient_id': patientUid,
      'medicine_id': medicineUid,
      'code': code
    });
    if (response.statusCode == 201) {
      print("Ekleme başarılı.");
    } else {
      print("Hata.");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _medicines =
    new List.generate(_count, (int i) => _buildMedicine());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text(
            "Yeni reçete oluştur",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text("Reçete kodu: $code"),
          Container(
            height: 250,
            width: double.infinity,
            child: ListView(
              children: _medicines,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            color: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Ekle",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _prescriptions.forEach(
                      (prescription) {
                    print(prescription);
                    createPrescription(
                      doctorUid: prescription["doctor_id"].toString(),
                      patientUid: prescription["patient_id"].toString(),
                      medicineUid: prescription["medicine_id"].toString(),
                      morningNumber: prescription["morning_number"],
                      morningTime: prescription["morning_time"],
                      noonNumber: prescription["noon_number"],
                      noonTime: prescription["noon_time"],
                      eveningNumber: prescription["evening_number"],
                      eveningTime: prescription["evening_time"],
                      code: prescription["code"],
                    );
                    notificationService.sendNotification(
                      doctorUid: prescription["doctor_id"].toString(),
                      patientUid: prescription["patient_id"].toString(),
                      patientDevicePlayerId: widget.patientDevicePlayerId,
                      medicineUid: prescription["medicine_id"].toString(),
                      medicineName: prescription["medicine_name"],
                      image: prescription["image"],
                      time: prescription["morning_time"],
                      code: prescription["code"],
                    );
                    notificationService.sendNotification(
                      doctorUid: prescription["doctor_id"].toString(),
                      patientUid: prescription["patient_id"].toString(),
                      patientDevicePlayerId: widget.patientDevicePlayerId,
                      medicineUid: prescription["medicine_id"].toString(),
                      medicineName: prescription["medicine_name"],
                      image: prescription["image"],
                      time: prescription["noon_time"],
                      code: prescription["code"],
                    );
                    notificationService.sendNotification(
                      doctorUid: prescription["doctor_id"].toString(),
                      patientUid: prescription["patient_id"].toString(),
                      patientDevicePlayerId: widget.patientDevicePlayerId,
                      medicineUid: prescription["medicine_id"].toString(),
                      medicineName: prescription["medicine_name"],
                      image: prescription["image"],
                      time: prescription["evening_time"],
                      code: prescription["code"],
                    );
                  },
                );
              });
              Navigator.pop(context);
            },
          ),
          // DatePicker yazılacak
        ],
      ),
    );
  }
}