import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_dropdown/common/enums/icon_function.dart';
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

  testWidgets('Show input dropdown with hide dropdown icon - Dropdown display',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);
  });

  testWidgets(
      'Show input dropdown with hide dropdown icon - Click on first dropdown value',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);

    // Tap on first item
    await gesture.moveTo(tester.getCenter(firstItemFinder));
    await tester.tap(firstItemFinder);

    await tester.pumpAndSettle();

    // Finders
    final iconTypeFinder = find.byType(Icon);
    final arrowUpFinder = find.byIcon(Icons.arrow_drop_up);
    final arrowDownFinder = find.byIcon(Icons.arrow_drop_down);
    final textDisplayedFinder = find.byType(Text);
    final dropdownFirstItemFinder = find.text('first');
    final dropdownSecondItemFinder = find.text('second');

    // Expect
    expect(iconTypeFinder, findsOneWidget);
    expect(arrowUpFinder, findsNothing);
    expect(arrowDownFinder, findsOneWidget);
    expect(textDisplayedFinder, findsOneWidget);
    expect(dropdownFirstItemFinder, findsOneWidget);
    expect(dropdownSecondItemFinder, findsNothing);
  });

  testWidgets(
      'Show input dropdown with hide dropdown icon - Click on second dropdown value',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);

    // Tap on second item
    await gesture.moveTo(tester.getCenter(secondItemFinder));
    await tester.tap(secondItemFinder);

    await tester.pumpAndSettle();

    // Finders
    final iconTypeFinder = find.byType(Icon);
    final arrowUpFinder = find.byIcon(Icons.arrow_drop_up);
    final arrowDownFinder = find.byIcon(Icons.arrow_drop_down);
    final textDisplayedFinder = find.byType(Text);
    final dropdownFirstItemFinder = find.text('first');
    final dropdownSecondItemFinder = find.text('second');

    // Expect
    expect(iconTypeFinder, findsOneWidget);
    expect(arrowUpFinder, findsNothing);
    expect(arrowDownFinder, findsOneWidget);
    expect(textDisplayedFinder, findsOneWidget);
    expect(dropdownFirstItemFinder, findsNothing);
    expect(dropdownSecondItemFinder, findsOneWidget);
  });

  testWidgets('Show input dropdown with hide dropdown icon - Tap icon twice',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);

    // Tap on icon again
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Hide dropdown finders
    // Dropdown finders
    final dropdownIconFinder = find.byType(Icon);
    final arrowUpIconFinder = find.byIcon(Icons.arrow_drop_up);
    final arrowDownIconFinder = find.byIcon(Icons.arrow_drop_down);
    final dropdownItemsFinder = find.byType(Text);
    final firstDropdownItemFinder = find.text('first');
    final secondDropdownItemFinder = find.text('second');

    // Expect
    expect(arrowUpIconFinder, findsNothing);
    expect(dropdownIconFinder, findsOneWidget);
    expect(arrowDownIconFinder, findsOneWidget);
    expect(dropdownItemsFinder, findsNothing);
    expect(firstDropdownItemFinder, findsNothing);
    expect(secondDropdownItemFinder, findsNothing);
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

  testWidgets(
      'Show input dropdown on tap widget with hide dropdown icon - Dropdown display',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);
  });

  testWidgets(
      'Show input dropdown on tap widget with hide dropdown icon - Click on first dropdown value',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);

    // Tap on first item
    await gesture.moveTo(tester.getCenter(firstItemFinder));
    await tester.tap(firstItemFinder);

    await tester.pumpAndSettle();

    // Finders
    final iconTypeFinder = find.byType(Icon);
    final arrowUpFinder = find.byIcon(Icons.arrow_drop_up);
    final arrowDownFinder = find.byIcon(Icons.arrow_drop_down);
    final textDisplayedFinder = find.byType(Text);
    final dropdownFirstItemFinder = find.text('first');
    final dropdownSecondItemFinder = find.text('second');

    // Expect
    expect(iconTypeFinder, findsOneWidget);
    expect(arrowUpFinder, findsNothing);
    expect(arrowDownFinder, findsOneWidget);
    expect(textDisplayedFinder, findsOneWidget);
    expect(dropdownFirstItemFinder, findsOneWidget);
    expect(dropdownSecondItemFinder, findsNothing);
  });

  testWidgets(
      'Show input dropdown on tap widget with hide dropdown icon - Click on second dropdown value',
      (WidgetTester tester) async {
    final items = ['first', 'second'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputDropdown<String>(
            showDropdownButton: const Icon(Icons.arrow_drop_down),
            hideDropdownButton: const Icon(Icons.arrow_drop_up),
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
    await gesture.moveTo(tester.getCenter(iconFinder));
    await tester.tap(iconContentFinder);

    await tester.pumpAndSettle();

    // Dropdown finders
    final hideDropdownIconFinder = find.byType(Icon);
    final hideDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_up);
    final showDropdownIconContentFinder = find.byIcon(Icons.arrow_drop_down);
    final itemsFinder = find.byType(Text);
    final firstItemFinder = find.text('first');
    final secondItemFinder = find.text('second');

    // Expect
    expect(showDropdownIconContentFinder, findsNothing);
    expect(hideDropdownIconFinder, findsOneWidget);
    expect(hideDropdownIconContentFinder, findsOneWidget);
    expect(itemsFinder, findsNWidgets(2));
    expect(firstItemFinder, findsOneWidget);
    expect(secondItemFinder, findsOneWidget);

    // Tap on second item
    await gesture.moveTo(tester.getCenter(secondItemFinder));
    await tester.tap(secondItemFinder);

    await tester.pumpAndSettle();

    // Finders
    final iconTypeFinder = find.byType(Icon);
    final arrowUpFinder = find.byIcon(Icons.arrow_drop_up);
    final arrowDownFinder = find.byIcon(Icons.arrow_drop_down);
    final textDisplayedFinder = find.byType(Text);
    final dropdownFirstItemFinder = find.text('first');
    final dropdownSecondItemFinder = find.text('second');

    // Expect
    expect(iconTypeFinder, findsOneWidget);
    expect(arrowUpFinder, findsNothing);
    expect(arrowDownFinder, findsOneWidget);
    expect(textDisplayedFinder, findsOneWidget);
    expect(dropdownFirstItemFinder, findsNothing);
    expect(dropdownSecondItemFinder, findsOneWidget);
  });

  // TODO: Add test case with hover icon and hide dropdown icon
  // TODO: Add test case with hover icon and tap on first item
  // TODO: Add test case with hover icon and tap on second item
  // TODO: Add test case with hover widget
  testWidgets('Show input dropdown with hover option - Dropdown display',
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
            executeFunction: IconFunction.hoverWidget,
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
  // TODO: Add test case with hover widget and hide dropdown icon
  // TODO: Add test case with hover and tap on first item
  // TODO: Add test case with hover and tap on second item
  // TODO: Add test case with tap item action
  // TODO: Add test case with on submit input action
  // TODO: Add test case with textHint, textStyle, inputFormatter, mouseCursor and custom inputController
}
