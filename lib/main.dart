import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/qr_screen.dart';

void main() {
  runApp(const SmartWaterApp());
}

class SmartWaterApp extends StatelessWidget {
  const SmartWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Water Quality',
      theme: ThemeData(
        fontFamily: 'Poppins', // ← Use local Poppins globally
        brightness: Brightness.dark,
      ),
      home: const SplashScreen(),
    );
  }
}
