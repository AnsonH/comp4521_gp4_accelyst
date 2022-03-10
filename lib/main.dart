import 'package:comp4521_gp4_accelyst/screens/home/home.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/mnemonics.dart';
import 'package:comp4521_gp4_accelyst/screens/music/music.dart';
import 'package:comp4521_gp4_accelyst/screens/timer/timer.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/todo.dart';
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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo[800],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[800],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo[800],
        ),
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/todo": (context) => const Todo(),
        "/timer": (context) => const Timer(),
        "/music": (context) => const Music(),
        "/mnemonics": (context) => const Mnemonics(),
      },
    );
  }
}
