import 'dart:io';

import 'package:bayer/pages/onboarding_screens.dart';
import 'package:bayer/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  //TODO:This class is for handling ssl handshake error on news page
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "App Title", home: IntroScreen());
  }
}

//TODO:This class is for handling ssl handshake error on news page
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
