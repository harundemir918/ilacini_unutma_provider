import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../widgets/app_bar/app_bar_with_back_button.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/patient_list/patient_list.dart';
import '../../widgets/loading/loading.dart';
import '../../../providers/patients_provider.dart';

class PanelDoctorPatientsScreen extends StatefulWidget {
  @override
  _PanelDoctorPatientsScreenState createState() =>
      _PanelDoctorPatientsScreenState();
}

class _PanelDoctorPatientsScreenState extends State<PanelDoctorPatientsScreen> {
  LoadData patientIsReady;
  PatientsProvider provider;
  int uid;
  int type;

  @override
  void didChangeDependencies() {
    final provider = Provider.of<PatientsProvider>(context);
    if (this.provider != provider) {
      this.provider = provider;
      Future.microtask(() async {
        patientIsReady = await provider.fetchPatients(uid);
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getUserUidAndType();
    super.initState();
  }

  _getUserUidAndType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getInt("uid");
      type = prefs.getInt("type");
    });
  }

  @override
  Widget build(BuildContext context) {
    PatientsProvider usersProvider = Provider.of<PatientsProvider>(context);
    final patientsList = usersProvider.patientsList;

    return Scaffold(
      body: SafeArea(
        child: patientIsReady != null
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Column(
                    children: [
                      AppBarWithBackButton(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SearchBar(
                          hintText: "Hasta arayın",
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      PatientList(
                        patientIsReady: patientIsReady,
                        patientsList: patientsList,
                        uid: uid,
                        type: type,
                      ),
                    ],
                  ),
                ),
              )
            : Loading(),
      ),
    );
  }
}
