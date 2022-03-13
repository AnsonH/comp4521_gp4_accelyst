import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  /// Animate a page route transition with fade.
  ///
  /// Example usage:
  /// ```dart
  /// // Also works for `Navigator.pushReplacement()
  /// Navigator.push(
  ///   context,
  ///   FadeRoute(widget: const Home()),
  /// );
  /// ```
  ///
  /// External readings on page route transition:
  ///  - [Flutter Docs - Animate a page route transition](https://docs.flutter.dev/cookbook/animation/page-route-animation)
  ///  - [Medium article - Create Custom Router Transition](https://bit.ly/3q1jszk)
  ///
  FadeRoute({required Widget widget, int milliseconds = 100})
      : super(
          pageBuilder: (context, animation1, animation2) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // The `child` parameter is the widget returned from `pageBuilder`
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: milliseconds),
        );
}
