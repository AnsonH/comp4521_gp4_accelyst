import 'dart:ui';
import 'package:comp4521_gp4_accelyst/models/timer/ambient_sound.dart';
import 'package:comp4521_gp4_accelyst/screens/timer/ambient_bottom_sheet.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/audio_player_service.dart';
import 'package:comp4521_gp4_accelyst/utils/time_utils.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/circular_timer.dart';
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

  /// Timer has reached 0 and completed.
  complete,
}

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int durationSecs = 25 * 60;
  TimerState timerState = TimerState.stop;
  int ambientIndex = 0;

  final _audioPlayer = AudioPlayerService();
  final _timerController = CircularTimerController();

  void _startTimer() {
    setState(() => timerState = TimerState.resume);
    _timerController.start();
  }

  void _pauseTimer() {
    setState(() => timerState = TimerState.pause);
    _timerController.pause();
  }

  void _resumeTimer() {
    setState(() => timerState = TimerState.resume);
    _timerController.resume();
  }

  void _resetTimer({int? duration}) {
    setState(() => timerState = TimerState.stop);
    _timerController.reset(duration: duration ?? durationSecs);
  }

  void _onTimerComplete() {
    // TODO: Alert the user with sounds & notifications
    setState(() => timerState = TimerState.complete);
  }

  void _stopAlarmOnComplete() {
    // TODO: Stop the alarm sound
    _resetTimer();
  }

  void _playAmbientSound(int index) {
    final String assetPath = ambientSounds[index].assetPath;

    if (assetPath == "") {
      _audioPlayer.stop();
    } else {
      _audioPlayer.playAsset(
        assetPath,
        loop: true,
        volume: ambientSounds[index].volume,
      );
    }

    setState(() => ambientIndex = index);
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
      fontFeatures: [
        FontFeature.tabularFigures(), // Uniform width for each char
      ],
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
        drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,
        body: Container(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/timer_bg_wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerIconButton(
                    icon: Icons.tune,
                    onPressed: timerState == TimerState.stop ? () {} : null,
                  ),
                  const SizedBox(width: 50),
                  TimerIconButton(
                    icon: Icons.music_note,
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => AmbientBottomSheet(
                        initialIndex: ambientIndex,
                        onPressed: (index) => _playAmbientSound(index),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // TODO: Use `Stack` to add additional labels on top of the timer text
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Offstage(
                    offstage: timerState != TimerState.stop,
                    // https://pub.dev/packages/sleek_circular_slider
                    child: SleekCircularSlider(
                      min: 10, // in minutes
                      max: 120,
                      initialValue: durationSecs / 60,
                      onChangeEnd: (double mins) {
                        final duration = mins.toInt() * 60;
                        // Update timer duration
                        _resetTimer(duration: duration);
                        setState(() => durationSecs = duration);
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
                    offstage: timerState == TimerState.stop,
                    // https://pub.dev/packages/circular_countdown_timer/example
                    child: Column(
                      children: [
                        const SizedBox(height: sliderWidth / 2),
                        CircularTimer(
                          controller: _timerController,
                          duration: durationSecs,
                          size: timerSize,
                          fillColor: fillColor,
                          ringColor: ringColor,
                          textStyle: timerTextStyles,
                          onComplete: _onTimerComplete,
                        ),
                        const SizedBox(height: sliderWidth / 2),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TimerControls(
                state: timerState,
                onPressedStart: _startTimer,
                onPressedPause: _pauseTimer,
                onPressedResume: _resumeTimer,
                onPressedReset: _showResetTimerDialog,
                onPressedStopAlarm: _stopAlarmOnComplete,
              ),
              const SizedBox(height: 25),
              const Divider(
                thickness: 1,
                height: 20,
                color: Color.fromARGB(255, 83, 86, 108),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Upcoming To-dos",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Timer State: ${timerState.toString()}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
