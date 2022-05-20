// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:comp4521_gp4_accelyst/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Case 1: Timer Page (Home + Timer Settings)',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.tune));
    await tester.pump();

    // Testing
    expect(find.text('Session Duration (mins)'), findsOneWidget);
    expect(find.text('Short Break Duration (mins)'), findsOneWidget);
    expect(find.byIcon(Icons.info), findsNWidgets(2));
  });
}
