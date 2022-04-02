import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/time_utils.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/icon_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
  int durationSecs = 25 * 60;
  TimerState _timerState = TimerState.stop;

  final CountDownController _controller = CountDownController();

  void _startTimer() {
    setState(() => _timerState = TimerState.resume);
    _controller.start();
  }

  void _pauseTimer() {
    setState(() => _timerState = TimerState.pause);
    _controller.pause();
  }

  void _resumeTimer() {
    setState(() => _timerState = TimerState.resume);
    _controller.resume();
  }

  void _resetTimer() {
    setState(() => _timerState = TimerState.stop);
    _controller.restart(duration: durationSecs);
    _controller.pause();
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
    // Styles for both circular slider & timer
    const ringColor = Color.fromARGB(255, 83, 86, 108);
    final fillColor = Colors.amber.shade600;
    final double timerSize = MediaQuery.of(context).size.width * 0.7;
    const double sliderWidth = 20.0;
    const timerTextStyles = TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w600,
    );

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
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Offstage(
                    offstage: _timerState != TimerState.stop,
                    // https://pub.dev/packages/sleek_circular_slider
                    child: SleekCircularSlider(
                      min: 10, // in minutes
                      max: 120,
                      initialValue: durationSecs / 60,
                      onChangeEnd: (double mins) {
                        setState(() => durationSecs = mins.toInt() * 60);
                      },
                      appearance: CircularSliderAppearance(
                        startAngle: 270,
                        angleRange: 350,
                        size: timerSize + sliderWidth,
                        animationEnabled: false,
                        customWidths: CustomSliderWidths(
                          trackWidth: 5,
                          progressBarWidth: sliderWidth,
                          shadowWidth: sliderWidth * 2,
                        ),
                        customColors: CustomSliderColors(
                          dotColor: Colors.black,
                          trackColor: ringColor,
                          progressBarColors: [
                            fillColor,
                            Colors.amber.shade800,
                          ],
                          dynamicGradient: true,
                          shadowColor: Colors.amber,
                          shadowMaxOpacity: 0.05,
                        ),
                        // Slider value
                        infoProperties: InfoProperties(
                          mainLabelStyle: timerTextStyles,
                          modifier: (double mins) {
                            return constructTime(mins.toInt() * 60);
                          },
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: _timerState == TimerState.stop,
                    // https://pub.dev/packages/circular_countdown_timer/example
                    child: Column(
                      children: [
                        const SizedBox(height: sliderWidth / 2),
                        CircularCountDownTimer(
                          controller: _controller,
                          duration: durationSecs,
                          width: timerSize,
                          height: timerSize,
                          isReverse: true, // Reverse Countdown (max to 0)
                          isReverseAnimation: true,
                          autoStart: false,
                          isTimerTextShown: true,
                          fillColor: fillColor,
                          ringColor: ringColor,
                          textStyle: timerTextStyles,
                        ),
                      ],
                    ),
                  ),
                ],
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
              Text("Duration: ${constructTime(durationSecs)}"),
              Text("Timer State: ${_timerState.toString()}")
            ],
          ),
        ),
      ),
    );
  }
}
