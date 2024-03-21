import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kesehatan/pages/splash_page.dart';
import 'package:kesehatan/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Kesehatan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkGreen),
        fontFamily: GoogleFonts.quicksand().fontFamily,
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}
