import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_dropdown/widgets/hoverable_item.dart';

void main() {
  testWidgets('Hoverable item is not hovered', (WidgetTester tester) async {
    await tester.pumpWidget(
      HoverableItem(
        child: (isHovered) => Text(
          'Hello',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: isHovered ? Colors.blue : Colors.black),
        ),
      ),
    );

    // Finders
    final textFinder = find.text('Hello');
    final textWidgetFinder = find.byType(Text);

    // Expect
    expect(textFinder, findsOneWidget);
    expect(tester.widget<Text>(textWidgetFinder).style,
        const TextStyle(color: Colors.black));
  });

  testWidgets('Hoverable item is hovered', (WidgetTester tester) async {
    await tester.pumpWidget(
      HoverableItem(
        child: (isHovered) => Text(
          'Hello',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: isHovered ? Colors.blue : Colors.black),
        ),
      ),
    );

    // Finders
    // Finders
    final textFinder = find.text('Hello');
    final textWidgetFinder = find.byType(Text);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(textWidgetFinder));
    await tester.pump();

    // TODO: Add mouse cursor test

    // Expect
    expect(textFinder, findsOneWidget);
    expect(textWidgetFinder, findsOneWidget);
    expect(tester.widget<Text>(textWidgetFinder).style,
        const TextStyle(color: Colors.blue));
  });
}
