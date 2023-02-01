<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Input dropdown
Input dropdown is a simple flutter package that provides a simple way to create a dropdown with an input [like input time](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/time).

## Features
1. Provide a easy widget ready to use as TextField widget.
2. Allow input and dropdown customization.
3. Adapt widget for desktop and mobile platforms.

## Usage

To use this package, aadd input_dropdown as a [dependency in your pubspec.yaml file.](https://plus.fluttercommunity.dev/docs/overview/)

The developer need to know that input dropdown is a [Expanded widget](https://api.flutter.dev/flutter/widgets/Expanded-class.html), for this reason, input dropdown always take maximum width and height available of his parent. Also, input dropdown does not have any style by itself, in the first example below we can se that the box style is provided by the [Container parent widget](https://api.flutter.dev/flutter/widgets/Container-class.html).

### Example

```dart
// Import package
import 'package:input_dropdown/input_dropdown.dart';


const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
