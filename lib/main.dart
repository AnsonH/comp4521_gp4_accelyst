import 'package:animations/animations.dart';
import 'package:comp4521_gp4_accelyst/models/app_screen.dart';
import 'package:comp4521_gp4_accelyst/screens/home/home.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/mnemonics.dart';
import 'package:comp4521_gp4_accelyst/screens/settings/settings.dart';
import 'package:comp4521_gp4_accelyst/screens/timer/timer.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/todo.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/indexed_transition_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const appScreens = <AppScreen>[
  AppScreen(
    widget: Home(),
    drawerTitle: "Home",
    drawerIcon: Icons.home,
  ),
  AppScreen(
    widget: Timer(),
    drawerTitle: "Timer",
    drawerIcon: Icons.timer,
  ),
  AppScreen(
    widget: Mnemonics(),
    drawerTitle: "Mnemonics",
    drawerIcon: Icons.library_books,
  ),
  AppScreen(
    widget: Todo(),
    drawerTitle: "Todo",
    drawerIcon: Icons.format_list_bulleted,
  ),
  AppScreen(
    widget: Settings(),
    drawerTitle: "Settings",
    drawerIcon: Icons.settings,
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Index of the page to be currently shown.
  int _currentIndex = 0;

  /// Sets the index of the page to be displayed.
  void setPageIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelyst',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),

      // `Provider` will provide the `setPageIndex` method to all its children down the widget tree.
      // Our `NavDrawer` widget can then later access this value.
      home: Provider(
        create: (_) => setPageIndex,
        child: IndexedTransitionSwitcher(
          index: _currentIndex,
          transitionBuilder: (widget, anim1, anim2) {
            return FadeThroughTransition(
              animation: anim1,
              secondaryAnimation: anim2,
              child: widget,
            );
          },
          children: appScreens.map((screen) => screen.widget).toList(),
        ),
      ),
    );
  }
}
