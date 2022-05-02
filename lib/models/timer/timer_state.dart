/// Stores the state of the timer component located at the center of the Timer page.
///
/// Not to be confused with the state of the entire "Timer" page.
class TimerState {
  /// Number of seconds left
  int durationSecs = 25 * 60;

  /// Current stage of the timer.
  TimerStage stage = TimerStage.stop;

  /// Whether Focus Mode is on
  bool focusMode = false;

  /// Whether Pomodoro Mode is on
  bool pomodoroMode = false;

  /// Total number of Pomodoro sessions.
  int pomodoroMaxSessions = 4;

  /// Current number of Pomodoro session.
  int pomodoroCurrentSession = 0;

  /// Duration of short break in minutes.
  int pomodoroBreakDuration = 5;

  /// Whether we are taking a short break.
  bool pomodoroIsBreak = false;

  /// Initializes the state of the timer component.
  TimerState();
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
