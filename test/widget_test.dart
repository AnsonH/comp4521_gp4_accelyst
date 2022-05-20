// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:comp4521_gp4_accelyst/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main Test Cases',

      /// 'Test Case 1: Timer Page (Home + Timer Settings)'
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Testing
    expect(find.text('Timer'), findsOneWidget);
    expect(find.text('START'), findsOneWidget);
    expect(find.byIcon(Icons.tune), findsOneWidget);
    expect(find.byIcon(Icons.music_note), findsOneWidget);

    /// 'Test Case 3: Navigation Drawer'
    // Open the Navigation Drawer
    //await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    // Testing
    expect(find.text('Todo'), findsOneWidget);
    expect(find.text('Mnemonics'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    ///'Test Case 4: To-do (To-do Page)'
    // Goes to the To-do Page
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();
    await tester.tap(find.text('Todo'));
    await tester.pump();

    Widget checkbox = Checkbox(
        value: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: (bool? newValue) {});

    // Testing
    expect(find.text('Todo'), findsOneWidget);

    ///'Test Case 5: Mnemonics'
    // Goes to the To-do Page
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();
    await tester.tap(find.text('Mnemonics'));
    await tester.pump();

    // Testing
    expect(find.text('Mnemonics'), findsOneWidget);

    ///'Test Case 6: Settings'
    // Goes to the To-do Page
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();
    await tester.tap(find.text('Settings'));
    await tester.pump();

    // Testing
    expect(find.text('Settings'), findsOneWidget);
  });
}
