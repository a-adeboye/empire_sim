import 'package:flutter/material.dart';
import 'ui/glassmorphism_dashboard.dart';

void main() {
  runApp(EmpireSimApp());
}

class EmpireSimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empire & Dynasty Sim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey,
      ),
      home: GlassDashboard(),
    );
  }
}