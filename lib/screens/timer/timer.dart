import 'dart:math';
import 'dart:async';

import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

String constructTime(int seconds) {
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  int hour = seconds ~/ 3600;
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;
  return formatTime(hour) + ":" + formatTime(minute) + ":" + formatTime(second);
}

class _TimerState extends State<Timer> {
  int _seconds = 100;
  // Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {},
          )
        ],
      ),
      drawer: const NavDrawer(),
      body: Column(children: [
        Text("Timer"),
        ElevatedButton(
            onPressed: () {
              setState(() {
                --_seconds;
              });
            },
            child: Text("Start Timer")),
        Text(constructTime(_seconds)),
      ]),
    );
  }
}
