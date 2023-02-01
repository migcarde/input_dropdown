import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_dropdown/widgets/dropdown_icon.dart';

void main() {
  testWidgets(
      'Dropdown icon has place icon with function false, triggered on tap icon and has defauilt mouse cursor',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      DropdownIcon(
        icon: const Icon(Icons.place, textDirection: TextDirection.rtl),
        onFunction: (value) => null,
        functionTrigger: DropdownButtonIconTrigger.tap,
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.place);

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);
  });

  testWidgets(
      'Dropdown icon has place icon with function false, triggered on tap icon, has default mouse cursor and user tap on icon',
      (WidgetTester tester) async {
    final completer = Completer<bool>();
    await tester.pumpWidget(
      DropdownIcon(
        icon: const Icon(Icons.place, textDirection: TextDirection.rtl),
        onFunction: completer.complete,
        functionTrigger: DropdownButtonIconTrigger.tap,
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.place);

    // Tap on icon
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconFinder);

    await tester.pumpAndSettle();

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);
    expect(completer.isCompleted, isTrue);
    expect(await completer.future, isTrue);
  });

  testWidgets(
      'Dropdown icon has place icon with function false, triggered on tap icon, has default mouse cursor and user tap twice on icon',
      (WidgetTester tester) async {
    var testValue = false;
    await tester.pumpWidget(
      DropdownIcon(
        icon: const Icon(Icons.place, textDirection: TextDirection.rtl),
        onFunction: (value) => testValue = value,
        functionTrigger: DropdownButtonIconTrigger.tap,
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.place);

    // Tap on icon
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconFinder);

    await tester.pumpAndSettle();

    // Tap on icon again
    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);
    expect(testValue, isFalse);
  });

  testWidgets(
      'Dropdown icon has place icon with function false, triggered on tap icon, has default mouse cursor and user not hovering icon',
      (WidgetTester tester) async {
    var testValue = false;
    await tester.pumpWidget(
      DropdownIcon(
        icon: const Icon(Icons.place, textDirection: TextDirection.rtl),
        onFunction: (value) => testValue = value,
        functionTrigger: DropdownButtonIconTrigger.hover,
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.place);

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);
    expect(testValue, isFalse);
  });
}
