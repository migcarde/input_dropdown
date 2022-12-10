import 'package:flutter/widgets.dart';

class HoverableItem extends StatefulWidget {
  const HoverableItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget Function(bool) child;

  @override
  State<HoverableItem> createState() => _HoverableItemState();
}

class _HoverableItemState extends State<HoverableItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        isHovered = false;
        setState(() {});
      },
      child: widget.child(isHovered),
    );
  }
}
