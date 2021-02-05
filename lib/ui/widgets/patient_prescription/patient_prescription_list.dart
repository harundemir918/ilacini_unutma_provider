import 'package:flutter/material.dart';
import 'package:ilacini_unutma_provider/providers/prescriptions_provider.dart';

import '../../../models/prescriptions.dart';
import '../../../providers/patients_provider.dart';
import '../../widgets/loading/loading.dart';
import 'patient_prescription_card.dart';

class PatientPrescriptionList extends StatefulWidget {
  final LoadPrescription prescriptionIsReady;
  final List<PatientPrescription> prescriptionsList;

  PatientPrescriptionList({
    this.prescriptionIsReady,
    this.prescriptionsList,
  });

  @override
  _PatientPrescriptionListState createState() =>
      _PatientPrescriptionListState();
}

class _PatientPrescriptionListState extends State<PatientPrescriptionList> {
  @override
  Widget build(BuildContext context) {
    switch(widget.prescriptionIsReady) {
      case LoadPrescription.loaded:
        return Container(
          height: 400,
          child: ListView(
            children: widget.prescriptionsList.map((prescription) {
              return PatientPrescriptionCard(
                code: prescription.code,
                medicineName: prescription.medicineName,
                morningNumber: prescription.morningNumber,
                noonNumber: prescription.noonNumber,
                eveningNumber: prescription.eveningNumber,
              );
            }).toList(),
          ),
        );
        break;
      case LoadPrescription.notLoaded:
        return Center(
          child: Text(
            "Reçete bilgisi bulunamadı.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
        break;
      case LoadPrescription.waiting:
        return Loading();
        break;
      default:
        return Loading();
        break;
    }
  }
}
