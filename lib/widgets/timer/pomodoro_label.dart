import 'package:comp4521_gp4_accelyst/models/timer/timer_state.dart';
import 'package:flutter/material.dart';

/// Label to indicate the current Pomodoro status.
class PomodoroLabel extends StatelessWidget {
  /// State of the timer component.
  final TimerState timerState;

  /// Size of the timer. Used to compute the location of the label.
  final double timerSize;

  /// Creates a label to indicate the current Pomodoro status.
  const PomodoroLabel({
    Key? key,
    required this.timerState,
    required this.timerSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hide label if Pomodoro Mode is off
    if (!timerState.pomodoroMode) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(bottom: timerSize / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: timerState.pomodoroIsBreak
            ? [
                const Icon(Icons.free_breakfast, size: 20),
                const SizedBox(width: 12),
                const Text(
                  "Break",
                  style: TextStyle(fontSize: 18),
                ),
              ]
            : [
                const Icon(Icons.timer_sharp, size: 20),
                const SizedBox(width: 12),
                Text(
                  timerState.pomodoroStatus,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
      ),
    );
  }
}
