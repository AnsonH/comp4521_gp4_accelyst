import 'package:comp4521_gp4_accelyst/widgets/core/dark_theme_dialog.dart';
import 'package:flutter/material.dart';

/// Opens the info dialog for "Focus Mode" in the timer settings bottom sheet.
void showFocusModeInfoDialog(BuildContext context) {
  showDarkThemeDialog(
    context: context,
    title: "What is Focus Mode?",
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "If Focus Mode is on, you are prohibited from leaving this app. Your phone will vibrate until you return back to the app.",
        ),
        SizedBox(height: 20),
        Text(
          "You are allowed to visit other pages of this app if Focus Mode is on.",
        ),
      ],
    ),
    actions: [
      TextButton(
        child: const Text(
          'DISMISS',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}

/// Opens the info dialog for "Pomodoro Mode" in the timer settings bottom sheet.
void showPomodoroModeInfoDialog(BuildContext context) {
  showDarkThemeDialog(
    context: context,
    title: "What is Pomodoro Mode?",
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "In Pomodoro mode, sessions run automatically one after another. Each session is separated by a short break of typically 5 minutes.",
        ),
        SizedBox(height: 20),
        Text(
          "You can adjust the number of sessions and length of short break using the sliders.",
        ),
        SizedBox(height: 20),
        Text(
          "This mode helps increase your level of focus and productivity.",
        ),
      ],
    ),
    actions: [
      TextButton(
        child: const Text(
          'DISMISS',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}
