import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/time_utils.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/icon_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/timer_controls.dart';
import 'package:flutter/material.dart';

/// Describes the states of a timer.
enum TimerState {
  /// Timer has not started to count, which is the initial state.
  stop,

  /// Timer is counting and hasn't reached 0.
  resume,

  /// Timer has started counting but paused.
  pause,
}

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final int _duration = 100;
  final CountDownController _controller = CountDownController();
  TimerState _timerState = TimerState.stop;

  void _startTimer() {
    _controller.start();
    setState(() => _timerState = TimerState.resume);
  }

  void _pauseTimer() {
    _controller.pause();
    setState(() => _timerState = TimerState.pause);
  }

  void _resumeTimer() {
    _controller.resume();
    setState(() => _timerState = TimerState.resume);
  }

  void _resetTimer() {
    _controller.restart(duration: _duration);
    _controller.pause();
    setState(() => _timerState = TimerState.stop);
  }

  void _showResetTimerDialog() {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: darkThemeData(context),
        child: AlertDialog(
          title: const Text("Stop the timer session?"),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text(
                'STOP',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                _resetTimer();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double timerSize = MediaQuery.of(context).size.width * 0.7;

    return Theme(
      data: darkThemeData(context), // Apply dark theme to this page
      child: Scaffold(
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/timer_bg_wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerIconButton(
                    icon: Icons.tune,
                    onPressed: _timerState != TimerState.stop ? null : () {},
                  ),
                  const SizedBox(width: 50),
                  TimerIconButton(
                    icon: Icons.music_note,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              /* TODO for timer:
               *  - Use `Stack` to add additional labels on top of the timer text.
               *  - Detect when the timer reaches 0 secs.
               */
              // https://pub.dev/packages/circular_countdown_timer/example
              CircularCountDownTimer(
                controller: _controller,
                duration: _duration,
                width: timerSize,
                height: timerSize,
                isReverse: true, // Reverse Countdown (max to 0)
                isReverseAnimation: true,
                autoStart: false,
                isTimerTextShown: true,
                fillColor: Colors.amber.shade600,
                ringColor: const Color.fromARGB(255, 83, 86, 108),
                textStyle: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 45),
              TimerControls(
                state: _timerState,
                onPressedStart: _startTimer,
                onPressedPause: _pauseTimer,
                onPressedResume: _resumeTimer,
                onPressedReset: _showResetTimerDialog,
              ),
              const SizedBox(height: 40),
              Text(constructTime(_duration)),
            ],
          ),
        ),
      ),
    );
  }
}
