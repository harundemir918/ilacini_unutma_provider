import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../providers/prescriptions_provider.dart';

class PatientPrescriptionNameCard extends StatefulWidget {
  final String patientName;
  final String patientSurname;
  final int prescriptionCount;

  PatientPrescriptionNameCard({
    this.patientName,
    this.patientSurname,
    this.prescriptionCount,
  });

  @override
  _PatientPrescriptionNameCardState createState() => _PatientPrescriptionNameCardState();
}

class _PatientPrescriptionNameCardState extends State<PatientPrescriptionNameCard> {
  PrescriptionsProvider provider;
  int prescriptionCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.patientName} ${widget.patientSurname}",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            "${widget.prescriptionCount} reçete",
            style: TextStyle(
              color: lightGrayColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
