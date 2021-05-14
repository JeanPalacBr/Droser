import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lease_drones/UI/payment.dart';
import 'package:lease_drones/UI/receipt.dart';
import 'Services/HttpCert.dart';
import 'UI/login.dart';
import 'ViewModels/sharedPrefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    Login(),
  );
}
