import 'package:flutter/material.dart';

import '../../../constants.dart';

class PatientPrescriptionCard extends StatelessWidget {
  final String code;
  final String medicineName;
  final int morningNumber;
  final int noonNumber;
  final int eveningNumber;

  PatientPrescriptionCard({
    this.code,
    this.medicineName,
    this.morningNumber,
    this.noonNumber,
    this.eveningNumber,
  });

  Text _buildMedicineCount(String time, int number) {
    return Text(
      "$time: $number Tane",
      style: TextStyle(
        color: lightGrayColor,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                code,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                medicineName,
                style: TextStyle(
                  color: lightGrayColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildMedicineCount("Sabah", morningNumber),
              _buildMedicineCount("Öğle", noonNumber),
              _buildMedicineCount("Akşam", eveningNumber),
            ],
          ),
        ),
      ),
    );
  }
}
