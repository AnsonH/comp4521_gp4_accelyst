import 'package:comp4521_gp4_accelyst/screens/timer/timer.dart';
import 'package:comp4521_gp4_accelyst/widgets/timer/icon_button.dart';
import 'package:flutter/material.dart';

/// A set of control buttons for the timer.
class TimerControls extends StatelessWidget {
  final TimerState state;
  final void Function() onPressedStart;
  final void Function() onPressedPause;
  final void Function() onPressedResume;
  final void Function() onPressedReset;

  /// Creates a set of control buttons for the timer.
  ///
  /// [onPressedStart], [onPressedPause], [onPressedResume], and [onPressedReset] are callback functions
  /// for pressing the "⏵︎Start", "⏸︎", "⏵︎", and "⏹︎" buttons respectively.
  const TimerControls({
    Key? key,
    required this.state,
    required this.onPressedStart,
    required this.onPressedPause,
    required this.onPressedResume,
    required this.onPressedReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == TimerState.stop) {
      // Start button
      return ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow),
        label: const Text(
          "START",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.amber[600],
          onPrimary: Colors.black,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
        ),
        onPressed: onPressedStart,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause/Play button
          TimerIconButton(
            icon: state == TimerState.resume ? Icons.pause : Icons.play_arrow,
            hasBackground: true,
            onPressed: () {
              state == TimerState.resume ? onPressedPause() : onPressedResume();
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
