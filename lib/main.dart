import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lease_drones/UI/splashScreen.dart';
import 'Services/HttpCert.dart';
import 'ViewModels/sharedPrefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    Root(),
  );
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
