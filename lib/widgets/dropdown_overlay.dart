import 'package:flutter/material.dart';
import 'package:input_dropdown/common/constants/dimens.dart';
import 'package:input_dropdown/widgets/hoverable_item.dart';
import 'package:input_dropdown/widgets/models/dropdown_decoration.dart';

class DropdownOverlay<T> {
  OverlayEntry create({
    required BuildContext context,
    required LayerLink layerLink,
    required List<T> items,
    required Function(int) onSelectItem,
    required VoidCallback onMouseLeaveList,
    required DropdownDecoration dropdownDecoration,
    TextStyle? itemTextStyle,
    double offset = 0.0,
    EdgeInsets? itemPadding,
    BoxDecoration? itemDecoration,
    BoxDecoration? itemHoveredDecoration,
  }) {
    final dropdownInput = context.findRenderObject() as RenderBox;

    return OverlayEntry(
      builder: (overlayContext) => DefaultTextStyle(
        style: const TextStyle(color: Colors.black),
        child: Positioned(
          width: dropdownInput.size.width,
          height: dropdownInput.size.height,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset:
                Offset(Dimens.zeroValue, dropdownInput.size.height + offset),
            child: Padding(
              padding: EdgeInsets.all(dropdownDecoration.borderWidth),
              child: CustomPaint(
                painter: dropdownDecoration.painterForDropdownDecoration,
                child: MouseRegion(
                  onExit: (event) => onMouseLeaveList(),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (listContext, index) => HoverableItem(
                      child: (isHovered) => GestureDetector(
                        onTap: () => onSelectItem(index),
                        child: Container(
                          decoration: isHovered
                              ? itemHoveredDecoration
                              : itemDecoration,
                          child: Padding(
                            padding: itemPadding ??
                                const EdgeInsets.all(Dimens.zeroValue),
                            child: Text(
                              items[index].toString(),
                              style: itemTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
