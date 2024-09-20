import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:new_project/flip.dart'; // Update with the correct path
import 'package:new_project/themes/ligh.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Update with the correct path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: true,
      theme: lighTheme,
      home: HomePage(), // Redirect to HomePage
    );
  }
}
