import 'package:flutter/material.dart';
import 'package:kesehatan/pages/profile.dart';
// ignore: unused_import
import 'package:kesehatan/pages/splash_page.dart';
// ignore: unused_import
import 'package:kesehatan/pages/home_page.dart';
// ignore: unused_import
import 'package:kesehatan/pages/login.dart';
// ignore: unused_import
import 'package:kesehatan/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Kesehatan',
      home: SplashScreenPage(),
    );
  }
}
