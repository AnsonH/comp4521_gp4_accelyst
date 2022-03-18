import 'dart:math';
import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';

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
  final int _duration = 100;
  final CountDownController _controller = CountDownController();

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
        // https://pub.dev/packages/circular_countdown_timer/example
        Container(
            child: CircularCountDownTimer(
          controller: _controller,
          duration: _duration,
          initialDuration: 0,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          isReverse:
              true, // true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)
          autoStart: false,
          isTimerTextShown: true,
          fillColor: Colors.purpleAccent[100]!,
          ringColor: Colors.grey[300]!,
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
              child: const Text("Start"), onPressed: () => _controller.start()),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              child: const Text("Pause"), onPressed: () => _controller.pause()),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              child: const Text("Resume"),
              onPressed: () => _controller.resume()),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              child: const Text("Restart"),
              onPressed: () => _controller.restart(duration: _duration))
        ]),
        Text(constructTime(_duration)),
      ]),
    );
  }
}
