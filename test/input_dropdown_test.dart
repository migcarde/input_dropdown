import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_dropdown/input_dropdown.dart';

void main() {
  testWidgets('Show input dropdown with default values - No dropdown display',
      (tester) async {
    final items = ['first', 'second'];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            onSendItem: (item) => null,
            onSubmitInput: (value) => null,
            items: items,
          ),
        ),
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.arrow_drop_down);

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);
  });

  testWidgets('Show input dropdown with default values - Dropdown display',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            onSendItem: (item) => null,
            onSubmitInput: (value) => null,
            items: items,
          ),
        ),
      ),
    );

    // Finders
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.arrow_drop_down);

    // Expect
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);

    // Tap on icon
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(iconContentFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);
  });

  testWidgets('Show input dropdown with tap on widget - Dropdown display',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            onSendItem: (item) => null,
            onSubmitInput: (value) => null,
            items: items,
          ),
        ),
      ),
    );

    // Finders
    final textFieldFinder = find.byType(TextField);
    final iconFinder = find.byType(Icon);
    final iconContentFinder = find.byIcon(Icons.arrow_drop_down);

    // Expect
    expect(textFieldFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(iconContentFinder, findsOneWidget);

    // Tap on icon
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(textFieldFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);
  });
}
