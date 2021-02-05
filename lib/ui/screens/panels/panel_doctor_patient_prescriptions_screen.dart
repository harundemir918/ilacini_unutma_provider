import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../widgets/patient_prescription/patient_prescription_list.dart';
import '../../widgets/patient_prescription/patient_prescription_name_card.dart';
import '../../widgets/add_prescription_modal_sheet.dart';
import '../../widgets/app_bar/app_bar_with_back_button.dart';
import '../../widgets/loading/loading.dart';
import '../../../providers/prescriptions_provider.dart';

class PanelDoctorPatientPrescriptionsScreen extends StatefulWidget {
  final int doctorUid;
  final int patientUid;
  final String patientName;
  final String patientSurname;
  final String patientDevicePlayerId;

  PanelDoctorPatientPrescriptionsScreen({
    this.doctorUid,
    this.patientUid,
    this.patientName,
    this.patientSurname,
    this.patientDevicePlayerId,
  });

  @override
  _PanelDoctorPatientPrescriptionsScreenState createState() =>
      _PanelDoctorPatientPrescriptionsScreenState();
}

class _PanelDoctorPatientPrescriptionsScreenState
    extends State<PanelDoctorPatientPrescriptionsScreen> {
  PrescriptionsProvider provider;
  int type;
  int prescriptionCount;
  LoadPrescription prescriptionIsReady;

  // List<String> prescriptionCodeList = [];

  @override
  void didChangeDependencies() {
    final provider = Provider.of<PrescriptionsProvider>(context);
    if (this.provider != provider) {
      this.provider = provider;
      Future.microtask(() async {
        prescriptionIsReady = await provider.fetchPatientPrescriptions(
          doctorUid: widget.doctorUid,
          patientUid: widget.patientUid,
        );
        prescriptionCount = provider.prescriptionCodeListCount;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getType();
    super.initState();
  }

  _getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getInt("type");
    });
  }

  void _addNewPrescription(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddPrescriptionModalSheet(
          doctorUid: widget.doctorUid,
          patientUid: widget.patientUid,
          patientDevicePlayerId: widget.patientDevicePlayerId,
        );
      },
    );
  }

  refresh() async {
    // prescriptionsList.clear();
    // prescriptionCodeList.clear();
    // TODO: Patient refresh
  }

  @override
  Widget build(BuildContext context) {
    PrescriptionsProvider prescriptionsProvider =
        Provider.of<PrescriptionsProvider>(context);
    final prescriptionsList = prescriptionsProvider.prescriptionsList;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refresh(),
          child: prescriptionIsReady != null ? SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  AppBarWithBackButton(),
                  PatientPrescriptionNameCard(
                    patientName: widget.patientName,
                    patientSurname: widget.patientSurname,
                    prescriptionCount: prescriptionCount,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          "Reçeteler",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  PatientPrescriptionList(
                    prescriptionIsReady: prescriptionIsReady,
                    prescriptionsList: prescriptionsList,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: type == 1
                        ? FloatingActionButton.extended(
                            backgroundColor: secondaryColor,
                            label: Row(
                              children: [
                                Text("Reçete Ekle"),
                                Icon(Icons.add),
                              ],
                            ),
                            onPressed: () => _addNewPrescription(context),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ) : Loading(),
        ),
      ),
    );
  }
}
