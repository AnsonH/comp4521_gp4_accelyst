import 'dart:ui';

import 'package:comp4521_gp4_accelyst/models/timer/ambient_sound.dart';
import 'package:comp4521_gp4_accelyst/models/timer/timer_state.dart';
import 'package:comp4521_gp4_accelyst/screens/app_screen.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/audio_player_service.dart';
import 'package:comp4521_gp4_accelyst/utils/services/notification_service.dart';
import 'package:comp4521_gp4_accelyst/utils/services/settings_service.dart';
import 'package:comp4521_gp4_accelyst/utils/time_utils.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/dark_theme_dialog.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/slider_with_label.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/switch_with_label.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/ambient_bottom_sheet.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/circular_timer.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/icon_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/info_dialogs.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/pomodoro_label.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

// Extending with WidgetsBindingObserver allows us to detect whether user exits the app,
// which is useful when implementing Focus Mode.
class _TimerState extends State<Timer> with WidgetsBindingObserver {
  // User preferences
  // TODO: Min and max durations are no longer available in Settings page
  final Future<int> _minTimerDuration = SettingsService.getTimerMinTime();
  final Future<int> _maxTimerDuration = SettingsService.getTimerMaxTime();
  static int minTimerDuration = 10; // To be updated in `timerStateInit()`
  static int maxTimerDuration = 120; // To be updated in `timerStateInit()`

  // Dynamic states
  int ambientIndex = 0;
  final TimerState timerState = TimerState();

  // Services & controllers
  final _ambientPlayer = AudioPlayerService();
  final _alarmPlayer = AudioPlayerService();
  final _timerController = CircularTimerController();

  void _startTimer({bool incrementPomodoroSession = true}) {
    if (timerState.pomodoroMode && incrementPomodoroSession) {
      setState(() => timerState.pomodoroCurrentSession += 1);
    }

    setState(() => timerState.stage = TimerStage.resume);
    _timerController.start();
  }

  void _pauseTimer() {
    setState(() => timerState.stage = TimerStage.pause);
    _timerController.pause();
  }

  void _resumeTimer() {
    setState(() => timerState.stage = TimerStage.resume);
    _timerController.resume();
  }

  void _resetTimer({int? duration, bool resetPomodoro = false}) {
    if (timerState.pomodoroMode && resetPomodoro) {
      setState(() => timerState.resetPomodoro());
    }

    setState(() => timerState.stage = TimerStage.stop);
    _timerController.reset(
      duration: duration ?? timerState.sessionDuration * 60,
    );
  }

  void _onTimerComplete() {
    // Play alarm sound
    _alarmPlayer.playAsset("audio/timer_alarm.mp3", loop: true);

    // Creates notification
    // TODO: This notification will NOT fire at the right time if we exit the app.
    String message = "🎉 Your study timer has completed!";
    if (timerState.pomodoroMode) {
      if (timerState.isPomodoroFinished) {
        message = "🎉 You finished all Pomodoro sessions!";
      } else if (timerState.pomodoroIsBreak) {
        message = "Break has ended. Back to work! 💪";
      } else {
        message =
            "Pomodoro session ${timerState.pomodoroStatus} has completed!";
      }
    }
    _createTimerNotification(body: message);

    setState(() => timerState.stage = TimerStage.complete);
  }

  void _stopAlarmOnComplete() {
    _alarmPlayer.stop();

    // Start/End Pomodoro break
    if (timerState.pomodoroMode && !timerState.isPomodoroFinished) {
      setState(() => timerState.pomodoroIsBreak = !timerState.pomodoroIsBreak);

      int newDuration = timerState.pomodoroIsBreak
          ? timerState.pomodoroBreakDuration * 60
          : timerState.sessionDuration * 60;
      _resetTimer(duration: newDuration);
      _startTimer(incrementPomodoroSession: !timerState.pomodoroIsBreak);
    } else {
      _resetTimer(resetPomodoro: true);
    }
  }

  void _playAmbientSound(int index) {
    final String assetPath = ambientSounds[index].assetPath;

    if (assetPath == "") {
      _ambientPlayer.stop();
    } else {
      _ambientPlayer.playAsset(
        assetPath,
        loop: true,
        volume: ambientSounds[index].volume,
      );
    }

    setState(() => ambientIndex = index);
  }

  void _showResetTimerDialog() {
    showDarkThemeDialog(
      context: context,
      title: "Stop the timer session?",
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
            _resetTimer(resetPomodoro: true);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          Theme(
            data: darkThemeData(context),
            child: Material(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Timer Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SliderWithLabel(
                      label: "Session Duration (mins)",
                      initialValue: timerState.sessionDuration,
                      onChanged: (int mins) {
                        setState(() => timerState.sessionDuration = mins);
                      },
                      onChangeEnd: (int mins) {
                        // Update timer duration
                        _resetTimer(duration: mins * 60);
                      },
                      min: minTimerDuration,
                      max: maxTimerDuration,
                      verticalPadding: 0.0,
                      usePrimaryColor: false,
                    ),
                    SwitchWithLabel(
                      label: "Focus Mode",
                      initialValue: timerState.focusMode,
                      onChanged: (value) {
                        setState(() => timerState.focusMode = value);
                      },
                      onPressedInfo: () => showFocusModeInfoDialog(context),
                      usePrimaryColor: false,
                    ),
                    const Divider(thickness: 1),
                    SwitchWithLabel(
                      label: "Pomodoro Mode",
                      initialValue: timerState.pomodoroMode,
                      onChanged: (value) {
                        setState(() => timerState.pomodoroMode = value);
                      },
                      onPressedInfo: () => showPomodoroModeInfoDialog(context),
                      usePrimaryColor: false,
                    ),
                    SliderWithLabel(
                      label: "Sessions",
                      initialValue: timerState.pomodoroMaxSessions,
                      onChanged: (int mins) {
                        setState(() => timerState.pomodoroMaxSessions = mins);
                      },
                      min: 2,
                      max: 10,
                      usePrimaryColor: false,
                    ),
                    SliderWithLabel(
                      label: "Short Break Duration (mins)",
                      initialValue: timerState.pomodoroBreakDuration,
                      onChanged: (int mins) {
                        setState(() => timerState.pomodoroBreakDuration = mins);
                      },
                      min: 3,
                      max: 15,
                      usePrimaryColor: false,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timerStateInit();

    // Set up WidgetsBindingObserver (used to detect whether user leaves the app later)
    WidgetsBinding.instance!.addObserver(this);
  }

  /// Obtains user preferences related to the timer.
  void timerStateInit() async {
    minTimerDuration = await _minTimerDuration;
    maxTimerDuration = await _maxTimerDuration;
    await timerState.getSettings();
    setState(() {}); // Rebuild the widget since we mutated timerState
  }

  // Detects whether user leaves the app while Focus Mode is on
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Create a notification if user leaves the app while Focus Mode is on
    final isBackground = state == AppLifecycleState.paused;
    if (timerState.focusMode &&
        isBackground &&
        timerState.stage == TimerStage.resume) {
      NotificationService.createNotification(
        channelKey: NotificationChannelKey.timer,
        title: "❗ GO BACK TO ACCELYST",
        body: "Please do not leave Accelyst while Focus Mode is on.",
      );
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerIconButton(
                    icon: Icons.tune,
                    onPressed: timerState.stage == TimerStage.stop
                        ? () => _showSettingsBottomSheet()
                        : null,
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
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  if (timerState.pomodoroMode)
                    PomodoroLabel(
                      timerState: timerState,
                      timerSize: timerSize,
                    ),
                  Offstage(
                    offstage: timerState.stage != TimerStage.stop,
                    // https://pub.dev/packages/sleek_circular_slider
                    child: SleekCircularSlider(
                      min: minTimerDuration.toDouble(), // in minutes
                      max: maxTimerDuration.toDouble(),
                      initialValue: timerState.sessionDuration.toDouble(),
                      onChangeEnd: (double mins) {
                        final duration = mins.toInt();
                        setState(() => timerState.sessionDuration = duration);
                        // Update timer duration
                        _resetTimer(duration: duration * 60);
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
                    offstage: timerState.stage == TimerStage.stop,
                    child: Column(
                      children: [
                        const SizedBox(height: sliderWidth / 2),
                        CircularTimer(
                          controller: _timerController,
                          duration: timerState.sessionDuration * 60,
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
                timerState: timerState,
                onPressedStart: _startTimer,
                onPressedPause: _pauseTimer,
                onPressedResume: _resumeTimer,
                onPressedReset: _showResetTimerDialog,
                onPressedStopAlarm: _stopAlarmOnComplete,
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}

/// Creates a notification when timer is complete.
void _createTimerNotification({required String body}) {
  NotificationService.createNotification(
    channelKey: NotificationChannelKey.timer,
    title: "⏰ Study Timer",
    body: body,
    payload: {"pageIndex": getAppScreenPageIndex("Timer").toString()},
  );
}
