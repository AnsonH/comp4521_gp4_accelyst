import 'package:comp4521_gp4_accelyst/models/timer/timer_state.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/icon_button.dart';
import 'package:flutter/material.dart';

/// A set of control buttons for the timer.
class TimerControls extends StatelessWidget {
  final TimerState timerState;
  final void Function() onPressedStart;
  final void Function() onPressedPause;
  final void Function() onPressedResume;
  final void Function() onPressedReset;

  /// Callback for the button that appears when the timer is complete.
  final void Function() onPressedStopAlarm;

  /// Creates a set of control buttons for the timer.
  ///
  /// Corresponding callback functions for buttons:
  ///  - [onPressedStart] - ⏵︎Start
  ///  - [onPressedPause] - ⏸
  ///  - [onPressedResume] - ︎︎⏵
  ///  - [onPressedReset] - ⏹︎︎
  const TimerControls({
    Key? key,
    required this.timerState,
    required this.onPressedStart,
    required this.onPressedPause,
    required this.onPressedResume,
    required this.onPressedReset,
    required this.onPressedStopAlarm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (timerState.stage) {
      case TimerStage.stop:
        // "⏵︎Start" button
        return RoundedButton(
          icon: Icons.play_arrow,
          label: "START",
          onPressed: onPressedStart,
        );
      case TimerStage.complete:
        String label = "STOP ALARM";
        if (timerState.pomodoroMode && !timerState.isPomodoroFinished) {
          // `pomodoroIsBreak = false` means that now we should start break now
          label = timerState.pomodoroIsBreak ? "NEXT SESSION" : "START BREAK";
        }

        return RoundedButton(
          icon: (timerState.pomodoroMode && !timerState.isPomodoroFinished)
              ? Icons.play_arrow
              : Icons.stop,
          label: label,
          onPressed: onPressedStopAlarm,
        );
      default:
        // "⏸" and "⏹︎︎" buttons
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pause/Play button
            TimerIconButton(
              icon: timerState.stage == TimerStage.resume
                  ? Icons.pause
                  : Icons.play_arrow,
              hasBackground: true,
              onPressed: () {
                timerState.stage == TimerStage.resume
                    ? onPressedPause()
                    : onPressedResume();
              },
            ),
            const SizedBox(width: 50),
            // Stop button
            TimerIconButton(
              icon: Icons.stop,
              hasBackground: true,
              onPressed: onPressedReset,
            ),
          ],
        );
    }
  }
}

/// An elevated button with an icon and rounded corners.
class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onPressed;

  /// Creates an elevated button with an icon and rounded corners.
  const RoundedButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber[600],
        onPrimary: Colors.black,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
      ),
      onPressed: onPressed,
    );
  }
}
