import 'package:flutter/widgets.dart';

enum DropdownButtonIconTrigger {
  click,
  hover,
}

extension DropdownButtonIconTriggerExtensions on DropdownButtonIconTrigger {
  get isClick => this == DropdownButtonIconTrigger.click;
  get isHover => this == DropdownButtonIconTrigger.hover;
}

class DropdownIcon extends StatefulWidget {
  const DropdownIcon({
    Key? key,
    required this.icon,
    required this.onFunction,
    required this.functionTrigger,
    this.mouseCursor,
  }) : super(key: key);

  final Icon icon;
  final Function(bool) onFunction;
  final DropdownButtonIconTrigger functionTrigger;
  final MouseCursor? mouseCursor;

  @override
  State<DropdownIcon> createState() => _DropdownIconState();
}

class _DropdownIconState extends State<DropdownIcon> {
  bool isTriggered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.mouseCursor ?? SystemMouseCursors.click,
      onEnter: (event) => widget.functionTrigger.isHover
          ? _updateButton(isTriggered: true)
          : null,
      child: GestureDetector(
        onTap: () => widget.functionTrigger.isClick
            ? _updateButton(isTriggered: !isTriggered)
            : null,
        child: widget.icon,
      ),
    );
  }

  void _updateButton({required bool isTriggered}) {
    this.isTriggered = isTriggered;
    widget.onFunction(isTriggered);
    setState(() {});
  }
}
