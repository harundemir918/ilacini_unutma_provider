import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/notification_service.dart';
import 'providers/users_provider.dart';
import 'providers/patients_provider.dart';
import 'providers/prescriptions_provider.dart';
import 'providers/taken_medicines_provider.dart';
import 'providers/medicines_provider.dart';
import 'constants.dart';
import 'router.dart' as router;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notificationService = NotificationService();
  String notifyContent;

  @override
  void initState() {
    notificationService.configOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(notifyContent);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => PatientsProvider()),
        ChangeNotifierProvider(create: (context) => PrescriptionsProvider()),
        ChangeNotifierProvider(create: (context) => TakenMedicinesProvider()),
        ChangeNotifierProvider(create: (context) => MedicinesProvider()),
      ],
      child: MaterialApp(
        title: 'İlacını Unutma',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: primaryColor,
        ),
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: router.splashScreenRoute,
      ),
    );
  }
}
