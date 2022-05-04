/// Stores the state of the timer component located at the center of the Timer page.
///
/// Not to be confused with the state of the entire "Timer" page.
class TimerState {
  /// Duration of a session in seconds. Its value does not change while timer is counting.
  ///
  /// The number of seconds left of the timer is stored internally in the [CircularTimer] widget.
  int sessionDuration = 25 * 60;

  TimerStage stage = TimerStage.stop;

  bool focusMode = false;

  bool pomodoroMode = false;

  /// Total number of Pomodoro sessions.
  int pomodoroMaxSessions = 4;

  /// Current number of Pomodoro session.
  int pomodoroCurrentSession = 0;

  /// Duration of short break in minutes.
  int pomodoroBreakDuration = 5;

  bool pomodoroIsBreak = false;

  /// Initializes the state of the timer component.
  TimerState();

  /// Gets a string showing current Pomodoro session out of max. Pomodoro sessions (eg. "1 / 5").
  String get pomodoroStatus {
    return "$pomodoroCurrentSession / $pomodoroMaxSessions";
  }

  /// Whether current Pomodoro session is equal to maximum number of sessions.
  bool get isPomodoroFinished {
    return pomodoroCurrentSession == pomodoroMaxSessions;
  }

  /// Reset ongoing Pomodoro progress.
  void resetPomodoro() {
    pomodoroCurrentSession = 0;
    pomodoroIsBreak = false;
  }
}

/// Describes the stages of the timer.
enum TimerStage {
  /// Timer has not started to count, which is the initial state.
  stop,

  /// Timer is counting and hasn't reached 0.
  resume,

  /// Timer has started counting but paused.
  pause,

  /// Timer has reached 0 and completed.
  complete,
}
