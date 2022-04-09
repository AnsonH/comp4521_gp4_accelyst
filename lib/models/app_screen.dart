import 'package:flutter/material.dart';

/// Stores data related to a screen in the app.
class AppScreen {
  /// The screen widget.
  final Widget widget;

  /// Title of the screen page to be shown in navigation drawer.
  final String drawerTitle;

  /// Icon for the screen to be shown in the navigation drawer.
  final IconData drawerIcon;

  const AppScreen({
    required this.widget,
    required this.drawerTitle,
    required this.drawerIcon,
  });
}
