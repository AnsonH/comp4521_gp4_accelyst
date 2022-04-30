import 'package:animations/animations.dart';
import 'package:comp4521_gp4_accelyst/models/app_screen.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/notification_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/indexed_transition_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Initialize services
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    NotificationService.listenActions((notification) {
      // Redirect to a page after clicking on notification.
      String? pageIndex = notification.payload?['pageIndex'];
      if (pageIndex != null) {
        setState(() => _currentIndex = int.parse(pageIndex));
      }
    });
  }

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

  @override
  void dispose() {
    NotificationService.dispose();
    super.dispose();
  }
}
