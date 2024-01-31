import 'package:alarm_app/model/local_notifications.dart';
import 'package:alarm_app/view/pages/home_page.dart';
import 'package:alarm_app/view/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'model/alarm_class.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await Hive.openBox<Alarm>('alarms');
WidgetsFlutterBinding.ensureInitialized();
await LocalNoti.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.exo2TextTheme(),
        scaffoldBackgroundColor: Colors.blueGrey.shade200,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
