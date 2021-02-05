import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../screens/panels/panel_doctor_patient_prescriptions_screen.dart';

class PrescriptionListTile extends StatefulWidget {
  final int prescriptionDoctorUid;
  final int prescriptionPatientUid;
  final String prescriptionCode;
  final String prescriptionPatientName;
  final String prescriptionPatientSurname;
  final String prescriptionDate;
  final int type;

  PrescriptionListTile({
    this.prescriptionDoctorUid,
    this.prescriptionPatientUid,
    this.prescriptionCode,
    this.prescriptionPatientName,
    this.prescriptionPatientSurname,
    this.prescriptionDate,
    this.type,
  });

  @override
  _PrescriptionListTileState createState() => _PrescriptionListTileState();
}

class _PrescriptionListTileState extends State<PrescriptionListTile> {
  Widget _buildDoctorPrescriptionTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.prescriptionCode,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "${widget.prescriptionPatientName} ${widget.prescriptionPatientSurname}",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Text(
          widget.prescriptionDate,
          style: TextStyle(
            color: lightGrayColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientPrescriptionTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.prescriptionCode,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          widget.prescriptionDate,
          style: TextStyle(
            color: lightGrayColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.type == 2
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PanelDoctorPatientPrescriptionsScreen(
                    doctorUid: widget.prescriptionDoctorUid,
                    patientUid: widget.prescriptionPatientUid,
                    patientName: widget.prescriptionPatientName,
                    patientSurname: widget.prescriptionPatientSurname,
                  ),
                ),
              );
            }
          : () {},
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
              height: 100,
              child: widget.type == 1
                  ? _buildDoctorPrescriptionTile()
                  : _buildPatientPrescriptionTile(),
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
