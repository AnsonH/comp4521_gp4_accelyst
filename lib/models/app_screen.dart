import 'package:flutter/material.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/mnemonics.dart';
import 'package:comp4521_gp4_accelyst/screens/settings/settings.dart';
import 'package:comp4521_gp4_accelyst/screens/timer/timer.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/todo.dart';

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

const appScreens = <AppScreen>[
  AppScreen(
    widget: Timer(),
    drawerTitle: "Timer",
    drawerIcon: Icons.timer,
  ),
  AppScreen(
    widget: Todo(),
    drawerTitle: "Todo",
    drawerIcon: Icons.format_list_bulleted,
  ),
  AppScreen(
    widget: Mnemonics(),
    drawerTitle: "Mnemonics",
    drawerIcon: Icons.library_books,
  ),
  AppScreen(
    widget: Settings(),
    drawerTitle: "Settings",
    drawerIcon: Icons.settings,
  ),
];

/// Gets the index of a page given its title.
int getAppScreenPageIndex(String title) {
  return appScreens.indexWhere((screen) => screen.drawerTitle == title);
}
