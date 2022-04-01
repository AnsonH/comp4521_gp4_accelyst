import 'package:comp4521_gp4_accelyst/screens/home/home.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelyst',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      home: const Home(),
    );
  }
}
