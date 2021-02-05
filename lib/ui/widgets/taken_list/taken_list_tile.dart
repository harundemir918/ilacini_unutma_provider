import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../screens/panels/panel_doctor_patient_prescriptions_screen.dart';

class TakenListTile extends StatefulWidget {
  final int takenMedicinesDoctorUid;
  final int takenMedicinesPatientUid;
  final String takenMedicinesCode;
  final String takenMedicinesPatientName;
  final String takenMedicinesPatientSurname;
  final String takenMedicinesMedicineName;
  final String takenMedicinesTime;
  final int type;

  TakenListTile({
    this.takenMedicinesDoctorUid,
    this.takenMedicinesPatientUid,
    this.takenMedicinesCode,
    this.takenMedicinesPatientName,
    this.takenMedicinesPatientSurname,
    this.takenMedicinesMedicineName,
    this.takenMedicinesTime,
    this.type,
  });

  @override
  _TakenListTileState createState() => _TakenListTileState();
}

class _TakenListTileState extends State<TakenListTile> {
  Widget _buildDoctorTakenTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "${widget.takenMedicinesPatientName} ${widget.takenMedicinesPatientSurname}",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Text(
          widget.takenMedicinesCode,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          widget.takenMedicinesMedicineName,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          widget.takenMedicinesTime,
          style: TextStyle(
            color: lightGrayColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientTakenTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.takenMedicinesCode,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          widget.takenMedicinesTime,
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
      // onTap: widget.type == 2
      //     ? () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => PanelDoctorPatientPrescriptionsScreen(
      //               doctorUid: widget.prescriptionDoctorUid,
      //               patientUid: widget.prescriptionPatientUid,
      //               patientName: widget.prescriptionPatientName,
      //               patientSurname: widget.prescriptionPatientSurname,
      //             ),
      //           ),
      //         );
      //       }
      //     : () {},
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
                  ? _buildDoctorTakenTile()
                  : _buildPatientTakenTile(),
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
