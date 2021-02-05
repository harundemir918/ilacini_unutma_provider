import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../screens/panels/panel_doctor_patient_prescriptions_screen.dart';

class PatientListTile extends StatelessWidget {
  final int doctorUid;
  final int patientUid;
  final int type;
  final String patientName;
  final String patientSurname;
  final String patientDevicePlayerId;
  final int patientPrescriptionCount;

  PatientListTile({
    this.doctorUid,
    this.patientUid,
    this.type,
    this.patientName,
    this.patientSurname,
    this.patientDevicePlayerId,
    this.patientPrescriptionCount,
  });

  void navigateScreen(BuildContext context) {
    if (type == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PanelDoctorPatientPrescriptionsScreen(
            doctorUid: doctorUid,
            patientUid: patientUid,
            patientName: patientName,
            patientSurname: patientSurname,
            patientDevicePlayerId: patientDevicePlayerId,
          ),
        ),
      );
    } else {
      // Hasta sayfasına yönlendir
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateScreen(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 175,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "$patientName $patientSurname",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "$patientPrescriptionCount reçete",
                    style: TextStyle(
                      color: lightGrayColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
