import 'package:comp4521_gp4_accelyst/utils/time_utils.dart';
import 'package:flutter/material.dart';

/// A circular countdown timer.
///
/// Inspired by the [circular_countdown_timer](https://pub.dev/packages/circular_countdown_timer) package.
class CircularTimer extends StatefulWidget {
  /// Controller for [CircularTimer].
  final CircularTimerController controller;

  /// Timer duration in seconds.
  final int duration;

  /// Size of the timer.
  final double size;

  /// Called after the timer completes.
  final void Function()? onComplete;

  /// Color of the base ring.
  final Color? ringColor;

  /// Fill color of the timer.
  final Color? fillColor;

  /// Stroke width of the timer ring.
  final double strokeWidth;

  /// Text styles for the timer label.
  final TextStyle? textStyle;

  /// Creates a circular countdown timer.
  const CircularTimer({
    Key? key,
    required this.controller,
    required this.duration,
    required this.size,
    this.onComplete,
    this.ringColor,
    this.fillColor,
    this.strokeWidth = 5,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with TickerProviderStateMixin {
  /// Controller for the countdown animation.
  ///
  /// It linearly animates the [_progress] value from 1.0 to 0.0 (i.e., 100% to 0%) over `duration`
  /// seconds specified in the [CircularTimer] constructor.
  late AnimationController _controller;

  /// Progress of the timer.
  ///
  /// Having a value of 1.0 means that the timer has not started, while a value of 0.0 means that
  /// the timer has finished.
  double _progress = 1.0;

  @override
  void initState() {
    super.initState();

    // Bind the timer controller (not to be confused with animation controller)
    widget.controller._state = this;

    // Set up animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _controller.addListener(() {
      _checkTimerComplete();

      if (_controller.isAnimating) {
        setState(() => _progress = _controller.value);
      }
    });
  }

  /// Runs `onComplete` callback of [CircularTimer] if the timer completes.
  void _checkTimerComplete() {
    if (_controller.value == 0 && widget.onComplete != null) {
      widget.onComplete!();
    }
  }

  /// Gets a formatted time in "mm:ss" format.
  String get timerText {
    return constructTime(
      (_controller.duration!.inSeconds * _controller.value).toInt(),
    );
  }

  // Resets the [progress] state.
  void _resetProgress() {
    setState(() => _progress = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
            backgroundColor: widget.ringColor,
            color: widget.fillColor,
            value: _progress,
            strokeWidth: widget.strokeWidth,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Text(
            timerText,
            style: widget.textStyle ?? const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Controller for the [CircularTimer].
///
/// Provides timer controls ([start], [pause], [resume] & [reset]).
class CircularTimerController {
  late _CircularTimerState _state;

  /// Starts the timer.
  void start() {
    // Begins animating the value from 1.0 to 0.0.
    _state._controller.reverse(from: 1.0);
  }

  /// Pauses the timer.
  void pause() {
    _state._controller.stop(canceled: false);
  }

  /// Resumes the timer.
  void resume() {
    _state._controller.reverse(from: _state._controller.value);
  }

  /// Resets the timer.
  ///
  /// If [duration] is omitted, it uses the original duration of the timer.
  void reset({int? duration}) {
    int secs = duration ?? _state._controller.duration!.inSeconds;
    _state._controller.duration = Duration(seconds: secs);

    start();
    pause(); // Immediately pauses timer after starting
    _state._resetProgress(); // Resets timer's progress ring
  }
}
