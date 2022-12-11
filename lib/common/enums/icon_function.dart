import 'package:input_dropdown/widgets/dropdown_icon.dart';

enum IconFunction {
  hoverIcon,
  hoverWidget,
  tapIcon,
  tapWidget,
}

extension IconFunctionExtensions on IconFunction {
  get isHoverIcon => this == IconFunction.hoverIcon;
  get isHoverWidget => this == IconFunction.hoverWidget;
  get isHover => isHoverIcon || isHoverWidget;
  get isTapIcon => this == IconFunction.tapIcon;
  get isTapWidget => this == IconFunction.tapWidget;

  get dropdownButtonIconTrigger {
    if (isHoverIcon) {
      return DropdownButtonIconTrigger.hover;
    } else if (isTapIcon) {
      return DropdownButtonIconTrigger.tap;
    }
  }
}
