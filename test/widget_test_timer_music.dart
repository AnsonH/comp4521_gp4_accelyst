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
  testWidgets('Test Case 2: Timer Page (Ambient Sound)',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Opens the Ambient Menu
    await tester.tap(find.byIcon(Icons.music_note));
    await tester.pump();

    // Testing
    expect(find.text('Ambient Sound'), findsOneWidget);
    expect(find.text('None'), findsOneWidget);
    expect(find.text('Cafe'), findsOneWidget);
    expect(find.byIcon(Icons.train), findsOneWidget);
  });
}
